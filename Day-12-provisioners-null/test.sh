#!/bin/bash

# Update packages
sudo dnf update -y
# Install NGINX
sudo dnf install -y nginx

# Enable and start NGINX
sudo systemctl enable nginx
sudo systemctl start nginx

# Create HTML page
sudo tee /usr/share/nginx/html/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MultiCloud DevOps Dashboard</title>

<style>
body{
    margin:0;
    font-family:Arial,sans-serif;
    background:#0f172a;
    color:white;
}
header{
    background:#111827;
    padding:20px;
    text-align:center;
    font-size:28px;
    color:#00d4ff;
}
.container{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(300px,1fr));
    gap:20px;
    padding:30px;
}
.card{
    background:#1e293b;
    padding:20px;
    border-radius:12px;
    box-shadow:0 0 10px rgba(0,212,255,.2);
}
h2{
    color:#00d4ff;
}
.status{
    color:#00ff88;
    font-weight:bold;
}
footer{
    text-align:center;
    padding:20px;
    color:#aaa;
}
</style>

</head>
<body>

<header>
☁ MultiCloud DevOps Dashboard
</header>

<div class="container">

<div class="card">
<h2>User Information</h2>
<p>Name: DevOps Admin</p>
<p>Email: admin@example.com</p>
<p>Role: Cloud Engineer</p>
</div>

<div class="card">
<h2>NGINX Status</h2>
<p class="status">Running ✓</p>
<p>Requests/sec: 2450</p>
</div>

<div class="card">
<h2>AWS</h2>
<p>EC2: Running</p>
<p>Auto Scaling: Enabled</p>
</div>

<div class="card">
<h2>Azure</h2>
<p>VM Scale Set: Healthy</p>
</div>

<div class="card">
<h2>Google Cloud</h2>
<p>GKE Cluster: Running</p>
</div>

<div class="card">
<h2>Kubernetes</h2>
<p>Pods: 15 Running</p>
<p>Services: 8 Active</p>
</div>

</div>

<footer>
AWS | Azure | GCP | Docker | Kubernetes | NGINX
</footer>

</body>
</html>
EOF

# Restart NGINX
sudo systemctl restart nginx