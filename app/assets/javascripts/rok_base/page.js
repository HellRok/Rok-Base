var Page = {
  blocks: function() {
    return $('#page_layout_id').attr('data-contents').split(";");
  },

  page_blocks: function() {
    return $.unique($.map(Page.blocks(), function(block) {
      var split = block.split(':');
      if (split[0] == 'page') return split[1];
    }));
  },

  update_layout: function() {
    $('#page_layout_id').attr('data-contents',
      $('#page_layout_id option:selected').attr('data-contents')
    );

    Page.load_layout();
  },

  load_layout: function() {
    var container = document.querySelector('.content-fields');
    container.innerHTML = '';

    $.each(Page.page_blocks(), function(i, block) {
      var
        wrapper = document.createElement('div'),
        label = document.createElement('label'),
        input_wrapper = document.createElement('div'),
        textarea = document.createElement('textarea');

      wrapper.className = 'pure-control-group pure-u-24-24 text optional page_content';
      label.className = 'text optional';
      input_wrapper.className = 'pure-input-wrapper';
      textarea.className = 'text optional pure-input-1 code-editor page-edit';

      label.textContent = clean(block);

      textarea.id = block;
      textarea.rows = 8;
      textarea.addEventListener('input', Page.save_content);
      // This is here for legacy support
      textarea.addEventListener('change', Page.save_content);
      textarea.dataset.mode = container.dataset.mode;
      textarea.dataset.theme = container.dataset.theme;
      textarea.dataset.keymap = container.dataset.keymap;

      wrapper.appendChild(label);
      input_wrapper.appendChild(textarea);
      wrapper.appendChild(input_wrapper);
      container.appendChild(wrapper);
    });

    if (!$('#new_page').length) {
      Page.populate_content();
    }

    initEditors();
  },

  populate_content: function() {
    var json = JSON.parse($('#page_content').val());

    $.each(Page.page_blocks(), function(i, block) {
      $('#' + block).val(json[block]);
    });
  },

  save_content: function() {
    var json = {};

    $.each(Page.page_blocks(), function(i, block) {
      json[block] = $('#' + block).val();
    });

    $('#page_content').val(JSON.stringify(json));
  },

  update_slug: function() {
    $('#page_slug').val(paramaterize($('#page_title').val()));
  }
}

$(document).ready(function() {
  // random element from the page form
  if ($('#page_slug').length > 0) {
    Page.load_layout();
    $('#page_layout_id').on('change', Page.update_layout);
  }

  if ($('#new_page').length > 0) {
    // backwards compatibility
    $('#page_title').on('change', Page.update_slug);
    $('#page_title').on('keyup', Page.update_slug);
  }
});

function clean(string) {
  string = string.charAt(0).toUpperCase() + string.slice(1);
  string = string.replace('_', ' ');
  string = string.replace('-', ' ');
  return string;
}

function paramaterize(string) {
  // http://stackoverflow.com/a/24849854
  return string.toLowerCase().replace(/[^a-z0-9]+/g,'-').replace(/(^-|-$)/g,'');
}
