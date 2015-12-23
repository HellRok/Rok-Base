var initEditors = function() {
  $('textarea.code-editor').each(function(index, elem) {
    var instance = CodeMirror.fromTextArea(elem, {
      theme: elem.dataset.theme,
      mode: elem.dataset.mode,
      keyMap: elem.dataset.keymap,
      lineNumbers: true,
      lineWrapping: true
    });

    if (elem.className.indexOf('page-edit') != -1) {
      instance.on('change', function(cm, change) {
        elem.value = instance.getValue();
        Page.save_content();
        console.log('beep');
      });
    }
  });
};

$(document).ready(function() {
  initEditors();
});
