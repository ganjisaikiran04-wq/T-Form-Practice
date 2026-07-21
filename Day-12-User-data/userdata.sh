#!/bin/bash

# Update system
dnf update -y

# Install NGINX
dnf install -y nginx

# Enable and start NGINX
systemctl enable nginx
systemctl start nginx

# Create custom web page
cat > /usr/share/nginx/html/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DevOps Dashboard</title>

<style>
body{
    background:#0f172a;
    color:white;
    font-family:Arial,sans-serif;
    text-align:center;
    padding:50px;
}
.container{
    max-width:900px;
    margin:auto;
    background:#1e293b;
    padding:40px;
    border-radius:15px;
}
.grid{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:15px;
    margin-top:30px;
}
.card{
    background:#2563eb;
    padding:20px;
    border-radius:10px;
}
</style>
</head>
<body>

<div class="container">

<h1>🚀 DevOps Dashboard</h1>
<h2>NGINX Successfully Deployed</h2>

<p>Infrastructure deployed successfully using Terraform.</p>

<div class="grid">
<div class="card">☁ AWS</div>
<div class="card">🐳 Docker</div>
<div class="card">⚙ Jenkins</div>
<div class="card">☸ Kubernetes</div>
<div class="card">🌐 NGINX</div>
<div class="card">📦 Terraform</div>
</div>

</div>

</body>
</html>
HTML

# Restart NGINX
systemctl restart nginx
