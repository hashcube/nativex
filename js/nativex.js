import util.setProperty as setProperty;

var onAdDismissed, onAdAvailable, onAdNotAvailable;

var NativeX = Class(function () {
	this.init = function(opts) {

		setProperty(this, "onAdDismissed", {
			set: function(f) {
				if (typeof f === "function") {
					onAdDismissed = f;
				} else {
					onAdDismissed = null;
				}
			},
			get: function() {
				return onOfferClose;
			}
		});

		setProperty(this, "onAdAvailable", {
			set: function(f) {
				if (typeof f === "function") {
					onAdAvailable = f;
				} else {
					onAdAvailable = null;
				}
			},
			get: function() {
				return onAdAvailable;
			}
		});

		setProperty(this, "onAdNotAvailable", {
			set: function(f) {
				if (typeof f === "function") {
					onAdNotAvailable = f;
				} else {
					onAdNotAvailable = null;
				}
			},
			get: function() {
				return onAdNotAvailable;
			}
		});

		NATIVE.events.registerHandler("NativeXAdDismissed", function() {
			logger.log("{NativeX} ad dismissed ");
			if (typeof onAdDismissed === "function") {
				onAdDismissed();
			}
		});

		NATIVE.events.registerHandler("NativeXAdAvailable", function() {
			logger.log("{NativeX} ad available");
			if (typeof onAdAvailable === "function") {
				onAdAvailable("nativex");
			}
		});

		NATIVE.events.registerHandler("NativeXAdNotAvailable", function() {
			logger.log("{NativeX} ad not available");
			if (typeof onAdNotAvailable === "function") {
				onAdNotAvailable();
			}
		});

	}
	this.showInterstitial = function() {
		NATIVE.plugins.sendEvent("NativeXPlugin", "showInterstitial", JSON.stringify({}));
	};

	this.cacheInterstitial = function() {
		NATIVE.plugins.sendEvent("NativeXPlugin", "cacheInterstitial", JSON.stringify({}));
	}
});

exports = new NativeX();
