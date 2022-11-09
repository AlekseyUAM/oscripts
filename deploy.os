#Использовать v8runner
#Использовать gitrunner

Процедура Загрузка()

	ТекущийКаталог = ТекущийКаталог();

	Контекст = Новый Структура;
	Контекст.Вставить("Исходники", ТекущийКаталог + "/src/cf");
	Контекст.Вставить("ИмяФайлаКонфигурации", ТекущийКаталог + "/temp_cf/master.cf");

	Попытка
		ОбновитьМастерВетку();
		ПолучитьКонфигурацию(Контекст);
		ЗагрузитьКонфигурацию(Контекст);
	Исключение
		Сообщить(ОписаниеОшибки());
	КонецПопытки;

КонецПроцедуры

Процедура ОбновитьМастерВетку()
	
	ГитРепозиторий = Новый ГитРепозиторий();
	ГитРепозиторий.УстановитьРабочийКаталог(ТекущийКаталог());
	ГитРепозиторий.ПерейтиВВетку("master");
	ГитРепозиторий.Получить("origin", "master");

КонецПроцедуры

Процедура ПолучитьКонфигурацию(Контекст)
	
	Конфигуратор = Новый УправлениеКонфигуратором();

	Конфигуратор.ЗагрузитьКонфигурациюИзФайлов(Контекст.Исходники);
	Сообщить("Конфигурация загружена из исходников");

	Конфигуратор.ВыгрузитьКонфигурациюВФайл(Контекст.ИмяФайлаКонфигурации);
	Сообщить("Конфигурация выгружена в cf");

	УдалитьФайлы(Конфигуратор.ПутьКВременнойБазе());

КонецПроцедуры

Процедура ЗагрузитьКонфигурацию(Контекст)
	
	Конфигуратор = Новый УправлениеКонфигуратором();

	ПараметрыСтрокиСоединения = Конфигуратор.ПараметрыСтрокиСоединения();
	ПараметрыСтрокиСоединения.ПутьКФайлуБазы = "/home/uam/Documents/InfoBase";
	Конфигуратор.УстановитьКонтекст(ПараметрыСтрокиСоединения, "admin", "admin");

	Конфигуратор.ЗагрузитьКонфигурациюИзФайла(Контекст.ИмяФайлаКонфигурации);

	Сообщить("Конфигурация загружена в целевую БД");

	УдалитьФайлы(Контекст.ИмяФайлаКонфигурации);

КонецПроцедуры


Загрузка();
