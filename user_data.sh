#!/bin/bash
# EC2 User Data Script for Web Server Configuration
# Author: Juan - Cloud Consultant
# Description: Initializes web server with Apache and connects to RDS

# Update system packages
yum update -y

# Install Apache web server
yum install -y httpd

# Install MySQL client
yum install -y mysql

# Install PHP and required modules
amazon-linux-extras install -y php7.4
yum install -y php-mysqlnd php-mbstring php-xml

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Configure firewall
systemctl start firewalld
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

# Get instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
LOCAL_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Create a simple health check endpoint
cat > /var/www/html/health <<'EOF'
OK
EOF

# Create index page with instance information
cat > /var/www/html/index.php <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3-Tier Web Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
        }
        .info {
            background-color: #e7f3ff;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
        }
        .info strong {
            color: #007bff;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 AWS 3-Tier Web Application</h1>
        
        <div class="info">
            <h2>Instance Information</h2>
            <p><strong>Instance ID:</strong> <?php echo gethostname(); ?></p>
            <p><strong>Server IP:</strong> <?php echo $_SERVER['SERVER_ADDR']; ?></p>
            <p><strong>Availability Zone:</strong> ${AVAILABILITY_ZONE}</p>
            <p><strong>PHP Version:</strong> <?php echo phpversion(); ?></p>
        </div>

        <div class="info">
            <h2>Database Connection Status</h2>
            <?php
            $db_host = "${db_endpoint}";
            $db_parts = explode(':', $db_host);
            $db_server = $db_parts[0];
            $db_port = isset($db_parts[1]) ? $db_parts[1] : 3306;
            
            // Test database connection
            $connection = @fsockopen($db_server, $db_port, $errno, $errstr, 5);
            
            if ($connection) {
                echo '<div class="success">✅ Database server is reachable at: ' . htmlspecialchars($db_host) . '</div>';
                fclose($connection);
            } else {
                echo '<div class="error">❌ Cannot connect to database server</div>';
                echo '<p>Error: ' . htmlspecialchars($errstr) . ' (Error code: ' . $errno . ')</p>';
            }
            ?>
        </div>

        <div class="info">
            <h2>Architecture Overview</h2>
            <ul>
                <li>✅ Presentation Tier: Application Load Balancer</li>
                <li>✅ Application Tier: Auto Scaling EC2 Instances</li>
                <li>✅ Data Tier: Multi-AZ RDS MySQL Database</li>
            </ul>
        </div>

        <div class="info">
            <h2>Features</h2>
            <ul>
                <li>High Availability across multiple AZs</li>
                <li>Auto Scaling based on CPU utilization</li>
                <li>Encrypted database storage</li>
                <li>CloudWatch monitoring and alarms</li>
                <li>Infrastructure as Code with Terraform</li>
            </ul>
        </div>

        <p style="text-align: center; color: #666; margin-top: 30px;">
            Deployed by: <strong>Juan - Cloud Consultant</strong><br>
            Managed with Terraform
        </p>
    </div>
</body>
</html>
EOF

# Set proper permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Restart Apache to apply changes
systemctl restart httpd

# Create log file for troubleshooting
echo "Instance initialized at $(date)" > /var/log/userdata.log
echo "Instance ID: $INSTANCE_ID" >> /var/log/userdata.log
echo "Availability Zone: $AVAILABILITY_ZONE" >> /var/log/userdata.log
echo "Local IP: $LOCAL_IP" >> /var/log/userdata.log
echo "Database endpoint: ${db_endpoint}" >> /var/log/userdata.log

# Optional: Install CloudWatch agent for enhanced monitoring
# wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
# rpm -U ./amazon-cloudwatch-agent.rpm

echo "User data script completed successfully" >> /var/log/userdata.log
