suite(function() {
	describe("unix_timestamp", function() {
		it("Should return 0 for the unix epoch", function() {
			expect(unix_timestamp(date_create_datetime(1970, 1, 1, 0, 0, 0))).toBe(0);
		});

		it("Should return the known timestamp of a known date", function() {
			expect(unix_timestamp(date_create_datetime(2022, 1, 1, 0, 0, 0))).toBe(1640995200);
		});

		it("Should count the seconds between two datetimes of the same day", function() {
			var _from = unix_timestamp(date_create_datetime(2024, 3, 9, 1, 0, 0));
			var _to = unix_timestamp(date_create_datetime(2024, 3, 9, 2, 30, 0));

			expect(_to - _from).toBe(5400);
		});

		it("Should be the exact inverse of unix_to_datetime", function() {
			expect(unix_timestamp(unix_to_datetime(0))).toBe(0);
			expect(unix_timestamp(unix_to_datetime(1640995200))).toBe(1640995200);
			expect(unix_timestamp(unix_to_datetime(1700000000))).toBe(1700000000);
		});

		it("Should return the same timestamp on both sides of a daylight saving change", function() {
			// January and July fall on a different UTC offset wherever DST is observed.
			expect(unix_timestamp(date_create_datetime(2024, 1, 15, 0, 0, 0))).toBe(1705276800);
			expect(unix_timestamp(date_create_datetime(2024, 7, 4, 0, 0, 0))).toBe(1720051200);
		});

		it("Should count a leap day", function() {
			var _from = unix_timestamp(date_create_datetime(2024, 2, 28, 0, 0, 0));
			var _to = unix_timestamp(date_create_datetime(2024, 3, 1, 0, 0, 0));

			expect(_to - _from).toBe(86400 * 2);
		});

		it("Should skip the leap day on a non leap year", function() {
			var _from = unix_timestamp(date_create_datetime(2023, 2, 28, 0, 0, 0));
			var _to = unix_timestamp(date_create_datetime(2023, 3, 1, 0, 0, 0));

			expect(_to - _from).toBe(86400);
		});
	});

	describe("unix_to_datetime", function() {
		it("Should return the epoch for a timestamp of 0", function() {
			var _dt = unix_to_datetime(0);

			expect(date_get_year(_dt)).toBe(1970);
			expect(date_get_month(_dt)).toBe(1);
			expect(date_get_day(_dt)).toBe(1);
		});

		it("Should round-trip a datetime through a unix timestamp", function() {
			var _dt = unix_to_datetime(unix_timestamp(date_create_datetime(2024, 3, 9, 4, 5, 6)));

			expect(date_get_year(_dt)).toBe(2024);
			expect(date_get_month(_dt)).toBe(3);
			expect(date_get_day(_dt)).toBe(9);
			expect(date_get_hour(_dt)).toBe(4);
			expect(date_get_minute(_dt)).toBe(5);
			expect(date_get_second(_dt)).toBe(6);
		});
	});

	describe("now", function() {
		it("Should return a timestamp after 2023", function() {
			expect(now()).toBeGreaterThan(1672531200);
		});

		it("Should match the current datetime", function() {
			expect(near(now(), unix_timestamp(date_current_datetime()), 2)).toBeTruthy();
		});
	});

	describe("unix_timestamp_format", function() {
		it("Should use the documented default format", function() {
			var _ts = unix_timestamp(date_create_datetime(2023, 11, 25, 13, 45, 7));
			expect(unix_timestamp_format(_ts)).toBe("2023-11-25 13:45:07");
		});

		it("Should resolve every unpadded token", function() {
			var _ts = unix_timestamp(date_create_datetime(2024, 7, 4, 9, 8, 7));

			expect(unix_timestamp_format(_ts, "%YYYY")).toBe("2024");
			expect(unix_timestamp_format(_ts, "%YY")).toBe("24");
			expect(unix_timestamp_format(_ts, "%M")).toBe("7");
			expect(unix_timestamp_format(_ts, "%D")).toBe("4");
			expect(unix_timestamp_format(_ts, "%H")).toBe("9");
			expect(unix_timestamp_format(_ts, "%mm")).toBe("July");
			expect(unix_timestamp_format(_ts, "%m")).toBe("Jul");
			expect(unix_timestamp_format(_ts, "%dd")).toBe("Thursday");
			expect(unix_timestamp_format(_ts, "%d")).toBe("Thu");
		});

		it("Should zero pad the padded tokens", function() {
			var _ts = unix_timestamp(date_create_datetime(2024, 3, 9, 4, 5, 6));

			expect(unix_timestamp_format(_ts, "%MM")).toBe("03");
			expect(unix_timestamp_format(_ts, "%DD")).toBe("09");
			expect(unix_timestamp_format(_ts, "%HH")).toBe("04");
			expect(unix_timestamp_format(_ts, "%NN")).toBe("05");
			expect(unix_timestamp_format(_ts, "%SS")).toBe("06");
		});

		it("Should keep the day separate from the month", function() {
			var _ts = unix_timestamp(date_create_datetime(2023, 11, 25, 0, 0, 0));

			expect(unix_timestamp_format(_ts, "%MM")).toBe("11");
			expect(unix_timestamp_format(_ts, "%DD")).toBe("25");
		});

		it("Should replace the longest token first", function() {
			var _ts = unix_timestamp(date_create_datetime(2024, 3, 9, 4, 5, 6));

			expect(unix_timestamp_format(_ts, "%YYYY|%YY")).toBe("2024|24");
			expect(unix_timestamp_format(_ts, "%MM|%M")).toBe("03|3");
			expect(unix_timestamp_format(_ts, "%HH|%H")).toBe("04|4");
		});

		it("Should name the weekday of the epoch", function() {
			expect(unix_timestamp_format(0, "%YYYY-%MM-%DD")).toBe("1970-01-01");
			expect(unix_timestamp_format(0, "%dd")).toBe("Thursday");
			expect(unix_timestamp_format(0, "%d")).toBe("Thu");
		});

		it("Should name every weekday across a full week", function() {
			var _names = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

			for (var i = 0; i < 7; i++) {
				// 2024-01-01 was a Monday.
				var _ts = unix_timestamp(date_create_datetime(2024, 1, 1 + i, 0, 0, 0));
				expect(unix_timestamp_format(_ts, "%dd")).toBe(_names[i]);
			}
		});

		it("Should not drift across a daylight saving change", function() {
			var _winter = unix_timestamp(date_create_datetime(2024, 1, 15, 9, 8, 7));
			var _summer = unix_timestamp(date_create_datetime(2024, 7, 4, 9, 8, 7));

			expect(unix_timestamp_format(_winter, "%YYYY-%MM-%DD %HH:%NN:%SS")).toBe("2024-01-15 09:08:07");
			expect(unix_timestamp_format(_summer, "%YYYY-%MM-%DD %HH:%NN:%SS")).toBe("2024-07-04 09:08:07");
		});

		it("Should format a leap day", function() {
			var _ts = unix_timestamp(date_create_datetime(2024, 2, 29, 12, 0, 0));

			expect(unix_timestamp_format(_ts, "%YYYY-%MM-%DD")).toBe("2024-02-29");
		});

		it("Should leave text without tokens untouched", function() {
			expect(unix_timestamp_format(0, "no tokens here")).toBe("no tokens here");
			expect(unix_timestamp_format(0, "")).toBe("");
		});
	});

	describe("datetime_get_timestamp", function() {
		it("Should return the current time wrapped in angle brackets", function() {
			var _stamp = datetime_get_timestamp();

			expect(_stamp).toHaveLength(10);
			expect(string_char_at(_stamp, 1)).toBe("<");
			expect(string_char_at(_stamp, 10)).toBe(">");
			expect(string_char_at(_stamp, 4)).toBe(":");
			expect(string_char_at(_stamp, 7)).toBe(":");
		});
	});

	describe("current_week", function() {
		it("Should return a week number starting from 1", function() {
			expect(between(current_week(), 1, 54)).toBeTruthy();
		});
	});

	describe("current_day_of_year", function() {
		it("Should return a day inside the year", function() {
			expect(between(current_day_of_year(), 1, 366)).toBeTruthy();
		});
	});
});
