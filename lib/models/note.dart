
class Note {

	int _id;
	String _title;
	String _description;
  String _altkat;
  String _demalt;
  String _barkod;
	String _date;
	int _priority;

	Note(this._title, this._date, this._priority, [this._description]);

	Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

	int get id => _id;

	String get subeadi => _title;

	String get anakat => _description;

  String get altkat => _altkat;

  String get demalt => _demalt;

  String get barkod => _barkod;

	int get priority => _priority;

	String get date => _date;

	set subeadi(String newSubeadi) {
		if (newSubeadi.length <= 255) {
			this._title = newSubeadi;
		}
	}

	set anakat(String newAnakat) {
		if (newAnakat.length <= 255) {
			this._description = newAnakat;
		}
	}

	set altkat(String newAltkat) {
		if (newAltkat.length <= 255) {
			this._altkat = newAltkat;
		}
	}

  set demalt(String newDemalt) {
		if (newDemalt.length <= 255) {
			this._demalt = newDemalt;
		}
	}

   set barkod(String newBarkod) {
		if (newBarkod.length <= 255) {
			this._barkod = newBarkod;
		}
	}

	set priority(int newPriority) {
		if (newPriority >= 1 && newPriority <= 2) {
			this._priority = newPriority;
		}
	}

	set date(String newDate) {
		this._date = newDate;
	}

	// Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['title'] = _title;
		map['description'] = _description;
		map['priority'] = _priority;
		map['date'] = _date;

		return map;
	}

	// Extract a Note object from a Map object
	Note.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._title = map['title'];
		this._description = map['description'];
		this._priority = map['priority'];
		this._date = map['date'];
	}
}









