var title, version, file, submit;

form    = document.getElementById('js_form')
title   = document.getElementById('js_title')
version = document.getElementById('js_version')
file    = document.getElementById('js_file')
submit  = document.getElementById('js_submit')

validateClick = function(e) {
  if (!(title.value && version.value && file.value && submit.value)) {
    e.preventDefault();
    return false;
  }
}

form.addEventListener('submit', validateClick, true);
