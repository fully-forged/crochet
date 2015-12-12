window.onload = function() {
  var app = Elm.fullscreen(Elm.Main, {
    seedSignal: 0
  });

  var now = new Date();
  app.ports.seedSignal.send(now.valueOf());
};
