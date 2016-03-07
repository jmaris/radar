get_mountpoints = (machine_id) ->
  xhttp = new XMLHttpRequest

  xhttp.onreadystatechange = ->
    if xhttp.readyState == 4 and xhttp.status == 200
      ajaxresponse = xhttp.responseText
      ajaxresponse_json = JSON.parse(xhttp.responseText)
      select = document.getElementById('storage_alert_path')
      document.getElementById('storage_alert_path').options.length = 0
      i = 0
      while i < ajaxresponse.length
        select.options[select.options.length] = new Option(ajaxresponse_json.mountpoints[i])
        i++
    return

  xhttp.open 'GET', '../machine_mountpoints/' + machine_id, true
  xhttp.setRequestHeader 'Content-Type', 'application/json'
  xhttp.send null
  return