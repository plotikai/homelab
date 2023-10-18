<h1>Homelab</h1>

<h2>Adding Portainer to Your Environment</h2>

<p>To add Portainer to your existing environment, follow these steps to install the Portainer Agent.</p>

<h2>Checking if Intel Quick Sync is Enabled</h2>

<p>To check if Intel Quick Sync is enabled, run the following commands in your terminal:</p>

<pre>
cd /dev/dri
ls
</pre>

<p>You should see the following output:</p>

<pre>
card0
renderD128
</pre>
<img src="https://github.com/plotikai/homelab/assets/54569189/5393d3ea-fdb7-4dcd-a560-4933ebd94d03" alt="Quick Sync Enabled">


<p>If you do not see the expected output, you can try loading the <code>i915</code> module by running:</p>

<pre>
modprobe i915
</pre>

<p>Afterward, check again.</p>

