$(document).ready(function () {
  try {
    Typekit.load({
      async: true
    });
  } catch (e) {
  }

  $(".messages").animate({
    scrollTop: $(document).height()
  }, "fast");

  $("#profile-img").click(function () {
    $("#status-options").toggleClass("active");
  });

  $(".expand-button").click(function () {
    $("#profile").toggleClass("expanded");
    $("#contacts").toggleClass("expanded");
  });

  $("#status-options ul li").click(function () {
    $("#profile-img").removeClass();
    $("#status-online").removeClass("active");
    $("#status-away").removeClass("active");
    $("#status-busy").removeClass("active");
    $("#status-offline").removeClass("active");
    $(this).addClass("active");

    if ($("#status-online").hasClass("active")) {
      $("#profile-img").addClass("online");
      $.ajax({
        type: "GET",
        url: "/change-status/0"
      });
    } else if ($("#status-away").hasClass("active")) {
      $("#profile-img").addClass("away");
      $.ajax({
        type: "GET",
        url: "/change-status/1"
      });
    } else if ($("#status-busy").hasClass("active")) {
      $("#profile-img").addClass("busy");
      $.ajax({
        type: "GET",
        url: "/change-status/2"
      });
    } else if ($("#status-offline").hasClass("active")) {
      $("#profile-img").addClass("offline");
      $.ajax({
        type: "GET",
        url: "/change-status/3"
      });
    }
    $("#status-options").removeClass("active");
  });
});
