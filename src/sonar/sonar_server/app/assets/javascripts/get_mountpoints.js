  function get_mountpoints(machine_id)
  {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function ()
    {
      if (xhttp.readyState == 4 && xhttp.status == 200)
      {
        document.getElementById("mountpoint_list").innerHTML = xhttp.responseText;
      };
    };
    xhttp.open("GET", "../machine_mountpoints/"+machine_id, true);
    xhttp.setRequestHeader('Content-Type', 'application/json');
    xhttp.send(null);
  };
