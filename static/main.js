$(document).ready(function() {
    var reloading = 1;
    $("#send-add").click(function() {
        $.post("/constants", {"name":$("#add-name").val(),
                                  "type":$("#add-type").val(),
                                  "value":$("#add-value").val()},
                                  function(response) {
                                      location.reload();
                                  });

    });


    $("[id$=send]").click(function() {
        var the_id = $(this).attr("id");
        var eid = the_id.replace("-send", "");
        var constant_name = the_id.split("-")[0];
        console.log("sending");
        $.post("/constants/" + constant_name, {"value" : $("#" + eid).val()}, function(response) {
            reloading -= 1;
            if (reloading == 0) {
                console.log("reloading!");
                location.reload();
            }
        });
    });

    $("#update-all").click(function() {
        reloading = $("[id$=send]").length;
        $("[id$=send]").click();
    });
});
