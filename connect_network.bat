echo "disconnecting network drive"
net use w: /delete
echo "setting network drive"
net use w: \\192.168.56.10\wwwdev /user:wwwdev