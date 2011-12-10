if (Ax) {
  throw new Error("Ax already defined!");
}

var Ax = {
  loadFunction: function(object) {
    $.each(this.loadables, function(index, loadable) {
      loadable.loadFunction(object);
    });
  },
  registerLoadable: function(loadable)
  {
    this.loadables.push(loadable);
  },
  loadables: [],
  transformers: {},
  loadingP: function(center)
  {
    var retval = document.createElement('img');
    retval.style.position = 'relative';
    retval.style.top = '50%';
    retval.alt = "Loading";
    retval.src = "/assets/loading.gif";

    if (center)
    {
      var outer = document.createElement('div');

      outer.style.height = '90%';
      outer.style.marginLeft = 'auto';
      outer.style.marginRight = 'auto';
      outer.style.width = '107px';

      outer.html(retval);
      retval = outer;
    }

    return retval;
  }
};
