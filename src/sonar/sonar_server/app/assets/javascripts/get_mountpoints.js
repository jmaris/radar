  function get_mountpoints(machine_id)
  {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function ()
    {
      if (xhttp.readyState == 4 && xhttp.status == 200)
      {
        document.getElementById("mountpoint_list").innerHTML = xhttp.responseText;
        // document.getElementById("storage_alert_path").options.length = 0;
        document.forms["storage_alert_form"].elements["storage_alert[path]"].options.length = 0;
      };
    };
    xhttp.open("GET", "../machine_mountpoints/"+machine_id, true);
    xhttp.setRequestHeader('Content-Type', 'application/json');
    xhttp.send(null);
  };