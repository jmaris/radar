  function get_mountpoints(machine_id)
  {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function ()
    {
      if (xhttp.readyState == 4 && xhttp.status == 200)
      {
        ajaxresponse = xhttp.responseText;
        ajaxresponse_json = JSON.parse(ajaxresponse)
        // select_name = "storage_alert[path]";
        // form_name = "storage_alert_form";
        var select = document.getElementById("storage_alert_path")
        document.getElementById("mountpoint_list").innerHTML = ajaxresponse;
        document.getElementById("storage_alert_path").options.length = 0;
        // document.forms[form_name].elements["storage_alert[path]"].options.length = 0;
//         
//         var master=document.myform.master
//         for (i=0; i<somevariable; i++){
//           master.options[master.options.length]=new Option(...)
//         }
//      //
        var select=document.getElementById("storage_alert_path")
        for (i=0; i<ajaxresponse.length; i++){
          select.options[select.options.length] = new ajaxresponse_json.mountpoints[i]
        }
      };
    };
    xhttp.open("GET", "../machine_mountpoints/"+machine_id, true);
    xhttp.setRequestHeader('Content-Type', 'application/json');
    xhttp.send(null);
  };