// vim: syntax=c

using Toybox.WatchUi;
using Toybox.System;
using Toybox.Math;
using Toybox.FitContributor;

class DataField extends WatchUi.SimpleDataField {
	const PRES_FIELD_ID = 0;
	hidden var pres_field;
	hidden var old_pres;

	function initialize() {
		SimpleDataField.initialize();
		label = "Pressure";

		pres_field = createField(
				"presery",
				PRES_FIELD_ID,
				FitContributor.DATA_TYPE_FLOAT,
				{:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"mmHg"});
	}

	function compute(info) {
		var stats = Activity.getActivityInfo();
		var new_pres = stats.ambientPressure;
		if (new_pres != old_pres) {
			pres_field.setData(new_pres);
			old_pres = new_pres;
		}
		return stats.presery.format("%0.1f");
	}
}
