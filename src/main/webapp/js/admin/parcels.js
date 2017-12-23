/**
 * Created by Vlad on 21.12.2017.
 */


$(document).ready(function() {

    $('#select-all').change(function() {
        var self = this;
        $.find(".select-parcel").forEach(function(item) {
            $(item).prop("checked", self.checked);
        });
    });

    $(".select-parcel").change(function() {
        if ($.find('.select-parcel:checked').length) {
            $('#select-status-for-all-parcels').removeClass('hidden');
        } else {
            $('#select-status-for-all-parcels').addClass('hidden');
        }
    })
});