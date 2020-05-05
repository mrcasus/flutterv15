
class Note {

	int _id;
	String _subeadi;
	String _anakat;
  String _altkat;
  String _demalt;
  String _barkod;

	String _date;
	int _priority;

	Note(this._subeadi, this._date, this._priority, [this._anakat]);

	Note.withId(this._id, this._subeadi, this._altkat, this._demalt, this._barkod, this._date, this._priority, [this._anakat]);

	int get id => _id;

	String get subeadi => _subeadi;

	String get anakat => _anakat;

  String get altkat => _altkat;

  String get demalt => _demalt;

  String get barkod => _barkod;

	int get priority => _priority;

	String get date => _date;

	set subeadi(String newSubeadi) {
		if (newSubeadi.length <= 255) {
			this._subeadi = newSubeadi;
		}
	}

	set anakat(String newAnakat) {
		if (newAnakat.length <= 255) {
			this._anakat = newAnakat;
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
		map['title'] = _subeadi;
		map['description'] = _anakat;
    map['altkategori'] = _altkat;
    map['demirbaskategori'] = _demalt;
    map['barkod'] = _barkod;
		map['priority'] = _priority;
		map['date'] = _date;

		return map;
	}

	// Extract a Note object from a Map object
	Note.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._subeadi = map['title'];
		this._anakat = map['description'];
    this._altkat = map['altkategori'];
    this._demalt = map['demirbaskategori'];
    this._barkod = map['barkod'];
		this._priority = map['priority'];
		this._date = map['date'];
	}
}









