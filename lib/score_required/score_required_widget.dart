import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'score_required_model.dart';
export 'score_required_model.dart';

class ScoreRequiredWidget extends StatefulWidget {
  const ScoreRequiredWidget({
    super.key,
    this.game,
  });

  final GamesRecord? game;

  @override
  State<ScoreRequiredWidget> createState() => _ScoreRequiredWidgetState();
}

class _ScoreRequiredWidgetState extends State<ScoreRequiredWidget> {
  late ScoreRequiredModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScoreRequiredModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Builder(
        builder: (context) {
          if (functions.matchWinner(widget!.game!) != null) {
            return Align(
              alignment: AlignmentDirectional(0, 0),
              child: Text(
                'Winner: ${functions.matchWinner(widget!.game!)?.player}',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0.0,
                    ),
              ),
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  functions.bowler(widget!.game!),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
