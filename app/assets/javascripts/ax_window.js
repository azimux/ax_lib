Ax.Window = {
  make: function(url, options) {
    var window = $.extend({}, Ax.Window.Methods);
    window.url = url;
    window.options = options || {};
    return window;
  },
  loadFunction: function(target) {
    target.find("a.popup").click(function() {
      var link = $(this);
      var content = link.attr("popup_content");
      var url = link.attr("href");

      var options = {};

      var popup_options = link.attr("popup_options");

      if (popup_options)
        options = $.parseJSON(popup_options);

      if (content)
        Ax.Window.launchContent(content, options);
      else
        Ax.Window.launch(url, options);
      return false;
    }
    );

      $.fn.scrollMeIntoView = function () {
          var $container = this.scrollParent(),
              containerTop = $container.offset().top,
              containerBottom = containerTop + $container.height(),
              elemTop = this.offset().top,
              elemBottom = elemTop + this.height();

          // if (elemTop < containerTop) {
          $container.scrollTop(elemTop);
          /* } else if (elemBottom > containerBottom) {
           $container.scrollTop(elemBottom - $container.height());
           }  */
      }
  }
};

Ax.Window.Methods = {
  _doAjax: function(ajax_options) {
    ajax_options = ajax_options || {};
    var dialog = this.dialog;
    var error_or_success = function(data) {
      dialog.html(data.responseText);
      Ax.loadFunction(dialog);
    };

    var error_handler = error_or_success;
    var success_handler = error_or_success;

    if (ajax_options.dataType === "text")
    {
      success_handler = function(data) {
        dialog.html(data);
        Ax.loadFunction(dialog)
      };
    }

    $.ajax($.extend({}, {
      url: this.url,
      dataType: 'json',
      success: success_handler,
      error: error_handler,
      complete: function()
      {
        dialog.dialog("cleanUp");
      }
    }, ajax_options));
  }
};

Ax.Window.ClassMethods = {
  defaultEffect: {
    effect: "fade",
    duration: 1000
  },
  _defaultOptions: {
    modal: true,
    width: 'auto',
    autoResize: true,
    close: function() {
      $(this).dialog('destroy').remove();
    }
  },
  defaultOptions: function() {
    return $.extend({
      maxWidth: $(window).width() - 50,
      maxHeight: $(window).height() - 50,
      show: this.defaultEffect,
      hide: this.defaultEffect
    }, this._defaultOptions);
  },
  launch: function(url, options)
  {
    options = $.extend({}, this.defaultOptions(), options);

    var window = this.make(url, options);

    var dialog = $("<div>");
    window.dialog = dialog;

    dialog.html(Ax.loadingP());
    if (window._prepDialog)
      window._prepDialog();
    dialog.dialog(options);

    window._doAjax(options.ajax_options);

    return window;
  },
  launchContent: function(content, options)
  {
    if (!options)
    {
      options = {};
    }

    options = $.extend({}, this.defaultOptions(), options);

    var dialog = $("<div>");
    dialog.dialog(options);
    dialog.html(content);
    dialog.dialog("cleanUp");

    return dialog;
  }
};

$.extend(Ax.Window, Ax.Window.ClassMethods);

if ($.ui.dialog.prototype.cleanUp || $.ui.dialog.cleanUp)
  throw new Error("cleanUp already exists for some reason");

$.ui.dialog.prototype.cleanUp = function() {
  var dialog = this.element;

  var widget = dialog.dialog("widget");
  var mw = dialog.dialog("option", "maxWidth");
  var mh = dialog.dialog("option", "maxHeight");
  if (widget.width() > mw) dialog.dialog("option", "width", mw);
  if (widget.height() > mh) dialog.dialog("option", "height", mh);
  dialog.dialog("option", "position", "center");

  return dialog;
};

$(function() {
  Ax.Window.loadFunction($("body"));
  Ax.registerLoadable(Ax.Window);
});
