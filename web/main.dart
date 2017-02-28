import 'dart:async';
import 'dart:html';

import 'package:console_log_handler/console_log_handler.dart';
import 'package:di/di.dart' as di;
import 'package:logging/logging.dart';
import 'package:mdl/mdl.dart';


@MdlComponentModel
@di.Injectable()
class App extends MaterialApplication {

    App() {
    }

    void run() {

        this._bind();
    }

    //- private -----------------------------------------------------------------------------------

    void _bind() async {

        final MaterialButton button = MaterialButton.widget(querySelector("#alert-button"));
        final MaterialAlertDialog alertDialog = new MaterialAlertDialog();

        button.onClick.listen((MouseEvent event) {
            alertDialog.open("Alert Message").show();
        });

    }

}

Future main() async {
    configLogging();
    registerMdl();

    final MaterialApplication application = await componentFactory().rootContext(App).run(enableVisualDebugging: true);

    application.run();

}

void configLogging() {
    hierarchicalLoggingEnabled = true; // set this to true - its part of Logging SDK

    // now control the logging.
    // Turn off all logging first
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen(new LogConsoleHandler());
}