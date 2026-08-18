// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Muscleup';

  @override
  String get workouts => 'Treinos';

  @override
  String get exercises => 'Exercícios';

  @override
  String get history => 'Histórico';

  @override
  String get settings => 'Ajustes';

  @override
  String get routines => 'Rotinas';

  @override
  String get sets => 'Séries';

  @override
  String get weight => 'Peso';

  @override
  String get reps => 'Reps';

  @override
  String get addRoutine => 'Adicionar rotina';

  @override
  String get addExercise => 'Adicionar exercício';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get back => 'Voltar';

  @override
  String get routineDetailsTitle => 'Detalhes da rotina';

  @override
  String get noRoutines => 'Nenhuma rotina encontrada';

  @override
  String get errorLoading => 'Erro ao carregar as rotinas';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get dashboardTitle => 'Painel';

  @override
  String get today => 'Hoje';

  @override
  String get noWorkoutToday => 'Nenhum treino registrado neste dia';

  @override
  String get startWorkout => 'Iniciar uma rotina';

  @override
  String get finishWorkout => 'Finalizar treino';

  @override
  String get workoutSavedSuccess => 'Treino salvo com sucesso!';

  @override
  String get finishWorkoutConfirmation =>
      'Tem certeza de que deseja finalizar e salvar este treino?';

  @override
  String get activeWorkoutTitle => 'Treino ativo';

  @override
  String get set => 'Série';

  @override
  String get target => 'Meta';

  @override
  String get actual => 'Real';

  @override
  String get routineName => 'Nome da rotina';

  @override
  String get exerciseName => 'Nome do exercício';

  @override
  String get notes => 'Observações';

  @override
  String get exerciseNotesLabel => 'Observações (opcional)';

  @override
  String get exerciseNotesHint => 'ex.: elíptico ou bicicleta';

  @override
  String get removeExercise => 'Remover exercício';

  @override
  String get addSet => 'Adicionar série';

  @override
  String get saveRoutineSuccess => 'Rotina salva com sucesso!';

  @override
  String get editRoutine => 'Editar rotina';

  @override
  String get routineNameHint => 'ex.: dia de perna, segunda';

  @override
  String get searchExercises => 'Buscar exercícios...';

  @override
  String get noResults => 'Nenhum exercício encontrado';

  @override
  String get noExercisesAdded => 'Nenhum exercício adicionado ainda';

  @override
  String addCustomExercise(String name) {
    return 'Adicionar \'$name\'';
  }

  @override
  String get searchHelper => 'Digite para buscar ou adicionar...';

  @override
  String get noSetsAdded => 'Nenhuma série adicionada';

  @override
  String get restTimeSeconds => 'Descanso (segundos)';

  @override
  String removeConfirmation(String name) {
    return 'Tem certeza de que deseja remover $name?';
  }

  @override
  String get remove => 'Remover';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLb => 'lb';

  @override
  String get unitReps => 'reps';

  @override
  String get unitSeconds => 's';

  @override
  String get unitMinutes => 'min';

  @override
  String get unitKm => 'km';

  @override
  String get unitMeters => 'm';

  @override
  String get unitNone => 'nenhuma';

  @override
  String get unitLevel => 'nível';

  @override
  String get unitIncline => 'inclinação';

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count séries',
      one: '1 série',
    );
    return '$_temp0';
  }

  @override
  String get language => 'Idioma';

  @override
  String get appSkin => 'Tema do app';

  @override
  String get skinVolt => 'Volt';

  @override
  String get skinCyan => 'Ciano';

  @override
  String get skinCrimson => 'Carmesim';

  @override
  String get skinRoyalGold => 'Ouro real';

  @override
  String get skinMonochrome => 'Monocromático';

  @override
  String get selectSkin => 'Escolher tema do app';

  @override
  String get noExercisesInRoutine => 'Nenhum exercício nesta rotina';

  @override
  String get deleteRoutineConfirm =>
      'Tem certeza de que deseja excluir esta rotina?';

  @override
  String get delete => 'Excluir';

  @override
  String get routineDeletedSuccess => 'Rotina excluída com sucesso!';

  @override
  String get emptyRoutine => 'Vazia';

  @override
  String get startNewSession => 'Iniciar nova sessão';

  @override
  String startRoutineName(String name) {
    return 'Iniciar $name';
  }

  @override
  String get addExercisesFirst => 'Adicione exercícios primeiro';

  @override
  String get deleteSessionConfirm =>
      'Tem certeza de que deseja excluir esta sessão de treino?';

  @override
  String get sessionDeleted => 'Sessão excluída';

  @override
  String get resting => 'Descansando';

  @override
  String get add30Seconds => '+30s';

  @override
  String get resumeWorkout => 'Retomar treino atual';

  @override
  String routineAlreadyActive(String name) {
    return 'Você já tem $name em andamento. Retomando.';
  }

  @override
  String get noLogsFound => 'Nenhum registro encontrado para esta sessão';

  @override
  String get activeWorkout => 'Treino ativo';

  @override
  String get inProgress => 'Em andamento...';

  @override
  String get completed => 'Concluído';

  @override
  String get pendingExercises => 'Pendentes';

  @override
  String get completedExercises => 'Concluídos';

  @override
  String get showCompletedExercises => 'Mostrar';

  @override
  String get hideCompletedExercises => 'Ocultar';

  @override
  String get completedSession => 'Sessão concluída';

  @override
  String get saveAsRoutineTarget => 'Salvar como meta da rotina';

  @override
  String get saveAsRoutineTargetSuccess =>
      'Meta atualizada para os próximos treinos';

  @override
  String get saveAsRoutineTargetError =>
      'Não foi possível atualizar a meta da rotina';

  @override
  String get editSetValue => 'Editar valor';

  @override
  String get saveForToday => 'Salvar para hoje';

  @override
  String get saveForTodayDetail => 'Registra o valor apenas neste treino';

  @override
  String get updateRoutineTarget => 'Atualizar meta';

  @override
  String get updateRoutineTargetDetail => 'Altera a meta dos próximos treinos';

  @override
  String get errorEmptyName => 'O nome da rotina não pode ficar vazio';

  @override
  String get noRoutinesAvailable => 'Nenhuma rotina disponível';

  @override
  String get createRoutineToGetStarted => 'Crie uma rotina para começar';

  @override
  String get errorNoExercises => 'A rotina precisa ter pelo menos um exercício';

  @override
  String get errorEmptySets =>
      'Cada exercício precisa ter pelo menos uma série';

  @override
  String get noSetsDefined => 'Nenhuma série definida';

  @override
  String get authAccount => 'Conta';

  @override
  String get authAnonymous => 'Anônimo';

  @override
  String get authAnonymousSubtitle =>
      'Seus dados ficam salvos no aparelho. Vincule uma conta para sincronizar.';

  @override
  String get authLinkedWithGoogle => 'Vinculado ao Google';

  @override
  String get authContinueWithGoogle => 'Continuar com o Google';

  @override
  String get authDisconnectGoogle => 'Desconectar do Google';

  @override
  String get authLinkSuccess => 'Conta vinculada com sucesso!';

  @override
  String get authGoogleSignInConfigurationError =>
      'O login com o Google não está configurado nesta versão. Adicione as impressões digitais SHA de release e do Play App Signing no Firebase.';

  @override
  String get authGoogleSignInTimeout =>
      'O login com o Google demorou demais. Tente novamente.';

  @override
  String get authUnavailable => 'Autenticação na nuvem indisponível';

  @override
  String get appInfoSection => 'APP';

  @override
  String get appVersionLabel => 'Versão';

  @override
  String get appBuildLabel => 'Build';

  @override
  String get darkMode => 'Modo escuro';

  @override
  String get trainingDefaultsSection => 'VALORES PADRÃO DE TREINO';

  @override
  String get defaultRest => 'Descanso padrão';

  @override
  String get defaultRepetitions => 'Repetições padrão';

  @override
  String get defaultWeight => 'Peso padrão';

  @override
  String get autoStartRestTimerOnComplete =>
      'Iniciar o descanso ao concluir a série';

  @override
  String get autoStartRestTimerOnCompleteSubtitle =>
      'Ao marcar uma série como concluída, o cronômetro começa sozinho';

  @override
  String get restSecondsDialogTitle => 'Descanso (segundos)';

  @override
  String get repetitionsDialogTitle => 'Repetições';

  @override
  String get weightKgDialogTitle => 'Peso (kg)';

  @override
  String get globalManagementSection => 'GERENCIAMENTO GERAL';

  @override
  String get manageExercises => 'Gerenciar exercícios';

  @override
  String get manageExercisesSubtitle =>
      'Edite, exclua e crie exercícios em um só lugar';

  @override
  String get exerciseLibraryTitle => 'Biblioteca de exercícios';

  @override
  String get newLabel => 'Novo';

  @override
  String get newExerciseTitle => 'Novo exercício';

  @override
  String get editExerciseTitle => 'Editar exercício';

  @override
  String get deleteExerciseTitle => 'Excluir exercício';

  @override
  String deleteExerciseConfirm(String name) {
    return 'Tem certeza de que deseja excluir $name?';
  }

  @override
  String get changesSaved => 'Alterações salvas';

  @override
  String get exerciseNameHint => 'Nome do exercício';

  @override
  String get noExercisesToShow => 'Nenhum exercício para mostrar';

  @override
  String get customLabel => 'Personalizado';

  @override
  String get libraryLabel => 'Biblioteca';

  @override
  String get syncCloudSection => 'SINCRONIZAÇÃO NA NUVEM';

  @override
  String get neverSynced => 'Nunca sincronizado';

  @override
  String get syncing => 'Sincronizando...';

  @override
  String get globalSyncOverlayTitle => 'Sincronizando seus dados';

  @override
  String get globalSyncOverlaySubtitle =>
      'Preparando rotinas e histórico da nuvem...';

  @override
  String get routinesSyncingPlaceholder => 'Buscando suas rotinas na nuvem...';

  @override
  String get syncPending => 'Sincronização pendente';

  @override
  String get synced => 'Backup feito';

  @override
  String get syncLocked => 'Backup desativado';

  @override
  String lastSync(String date) {
    return 'Última sincronização: $date';
  }

  @override
  String get linkGoogleForSync =>
      'Vincule sua conta do Google para ativar a sincronização na nuvem';

  @override
  String get refreshNow => 'Atualizar agora';

  @override
  String lastTimeValue(String value) {
    return 'Da última vez: $value';
  }

  @override
  String get exerciseProgressTitle => 'Progresso';

  @override
  String get viewProgress => 'Ver progresso';

  @override
  String get noProgressYet =>
      'Ainda não há registros. Conclua um treino com este exercício para ver seu progresso aqui.';

  @override
  String progressSessionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessões',
      one: '1 sessão',
    );
    return '$_temp0';
  }

  @override
  String get helpFeedbackSection => 'Ajuda e feedback';

  @override
  String get sendFeedback => 'Enviar feedback';

  @override
  String get sendFeedbackSubtitle => 'Sugestões, ideias ou relatar um problema';

  @override
  String get feedbackEmailSubject => 'Muscleup — Feedback';

  @override
  String get feedbackEmailBody =>
      'Escreva aqui seu feedback, ideia ou problema:';

  @override
  String get emailCopiedToClipboard =>
      'Não foi possível abrir seu app de e-mail. O endereço foi copiado para a área de transferência.';

  @override
  String get legalSection => 'Jurídico';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get privacyPolicySubtitle => 'Como o Muscleup trata seus dados';

  @override
  String privacyPolicyLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Última atualização: $dateString';
  }

  @override
  String get privacyPolicyIntro =>
      'O Muscleup é um app de acompanhamento de treinos. Esta política explica quais dados o app pode coletar, como eles são usados e quais opções você tem em relação a esses dados.';

  @override
  String get privacyPolicyDataTitle => 'Dados que coletamos';

  @override
  String get privacyPolicyDataItem1 =>
      'Informações da conta, como nome, endereço de e-mail e ID de usuário.';

  @override
  String get privacyPolicyDataItem2 =>
      'Dados de treino, como rotinas, exercícios, séries, peso, repetições, sessões, histórico e observações opcionais que você escreve no app.';

  @override
  String get privacyPolicyDataItem3 =>
      'Ajustes do app, como idioma, tema e preferências relacionadas ao treino.';

  @override
  String get privacyPolicyCollectionTitle => 'Como os dados são coletados';

  @override
  String get privacyPolicyCollectionItem1 =>
      'O app pode ser usado localmente, sem vincular uma conta.';

  @override
  String get privacyPolicyCollectionItem2 =>
      'Se você optar por vincular sua conta ao Google, o Muscleup usa o Firebase Authentication para o login.';

  @override
  String get privacyPolicyCollectionItem3 =>
      'Se você optar pela sincronização na nuvem, os dados são armazenados no Google Firebase Cloud Firestore e associados à sua conta.';

  @override
  String get privacyPolicyUsageTitle => 'Como usamos os dados';

  @override
  String get privacyPolicyUsageItem1 =>
      'Para permitir o login e a gestão da conta.';

  @override
  String get privacyPolicyUsageItem2 =>
      'Para salvar, sincronizar e restaurar suas rotinas e seu histórico de treinos.';

  @override
  String get privacyPolicyUsageItem3 =>
      'Para guardar suas preferências e oferecer as funções principais do app.';

  @override
  String get privacyPolicySharingTitle => 'Compartilhamento de dados';

  @override
  String get privacyPolicySharingBody =>
      'O Muscleup não vende seus dados nem os compartilha com terceiros para fins de publicidade ou marketing. Os dados podem ser processados por provedores de infraestrutura necessários para o funcionamento do app, como o Firebase Authentication e o Cloud Firestore.';

  @override
  String get privacyPolicySecurityTitle => 'Criptografia e segurança';

  @override
  String get privacyPolicySecurityBody =>
      'Os dados são transferidos por conexões seguras e criptografadas. O acesso aos dados sincronizados é restrito ao usuário autenticado que é dono deles.';

  @override
  String get privacyPolicyRetentionTitle => 'Retenção de dados';

  @override
  String get privacyPolicyRetentionBody =>
      'Os dados são mantidos enquanto você conservar sua conta e usar a sincronização na nuvem, a menos que solicite a exclusão. Alguns dados técnicos mínimos podem permanecer temporariamente em backups de infraestrutura por um período limitado.';

  @override
  String get privacyPolicyDeletionTitle => 'Exclusão da conta e dos dados';

  @override
  String get privacyPolicyDeletionBody =>
      'Você pode solicitar a exclusão da sua conta e de todos os dados associados a qualquer momento. A página de exclusão de conta traz as instruções completas, exatamente o que é excluído e quanto tempo leva. Confirmamos por e-mail assim que seus dados forem excluídos.';

  @override
  String get privacyPolicyChildrenTitle => 'Privacidade infantil';

  @override
  String get privacyPolicyChildrenBody =>
      'O Muscleup não é direcionado especificamente a crianças menores de 13 anos.';

  @override
  String get privacyPolicyContactTitle => 'Contato';

  @override
  String get privacyPolicyContactBody =>
      'Se você tiver dúvidas sobre esta política, escreva para:';

  @override
  String get privacyPolicyOpenOnline => 'Ver a versão online';

  @override
  String get privacyPolicyAccountDeletionPage =>
      'Abrir a página de exclusão de conta';

  @override
  String get privacyPolicyAccountDeletion => 'Solicitar exclusão por e-mail';

  @override
  String get accountDeletionEmailSubject =>
      'Muscleup — Solicitação de exclusão de conta';

  @override
  String get accountDeletionEmailBody =>
      'Gostaria de solicitar a exclusão da minha conta do Muscleup e de todos os dados associados.';

  @override
  String get couldNotOpenLink =>
      'Não foi possível abrir o link neste aparelho.';

  @override
  String get exitAppTitle => 'Sair do Muscleup?';

  @override
  String get exitAppMessage => 'Tem certeza de que deseja fechar o app?';

  @override
  String get exitAppConfirm => 'Sair';

  @override
  String get importTitle => 'Importar rotinas';

  @override
  String get importHeadline => 'Traga todo o seu plano em um só passo';

  @override
  String get importIntro =>
      'Cole o seu plano de treino e o Muscleup cria todas as rotinas, com exercícios, séries, pesos, repetições e notas. Qualquer assistente de IA consegue passar as suas anotações para o formato que o app espera.';

  @override
  String get importStep1 => 'Copie as instruções.';

  @override
  String get importStep2 =>
      'Cole em um chat de IA — ChatGPT, Claude, Gemini — seguidas das suas anotações de treino, exatamente como você as tem escritas.';

  @override
  String get importStep3 =>
      'Copie a resposta, cole abaixo e revise antes de importar.';

  @override
  String get importCopyInstructions => 'Copiar instruções';

  @override
  String get importInstructionsCopied =>
      'Instruções copiadas. Cole em um chat de IA junto com as suas anotações.';

  @override
  String importInstructionsLanguageNote(String language) {
    return 'As instruções estão em inglês porque os assistentes as seguem com mais precisão assim. As suas rotinas voltam em $language.';
  }

  @override
  String get importPasteLabel => 'A resposta do assistente';

  @override
  String get importPasteHint => 'Cole o JSON aqui';

  @override
  String get importPasteFromClipboard => 'Colar';

  @override
  String get importClipboardEmpty => 'Não há nada para colar.';

  @override
  String get importCheck => 'Revisar';

  @override
  String get importClear => 'Limpar';

  @override
  String get importAction => 'Importar';

  @override
  String get importPreviewTitle => 'Isto é o que será criado';

  @override
  String importRoutineSummary(int exerciseCount, int setCount) {
    return 'Exercícios: $exerciseCount · Séries: $setCount';
  }

  @override
  String get importNoticesTitle => 'Vale conferir';

  @override
  String get importSuccess => 'Rotinas importadas';

  @override
  String get importErrorEmptyInput => 'Cole primeiro a resposta do assistente.';

  @override
  String get importErrorInvalidJson =>
      'Esse texto não é JSON válido. Copie a resposta novamente incluindo as chaves, ou peça ao assistente para responder apenas com o JSON.';

  @override
  String get importErrorNoRoutines =>
      'Nenhuma rotina foi encontrada nesse texto. Ele precisa de uma lista “routines” com pelo menos um dia que tenha exercícios.';

  @override
  String importNoticeNoExercises(String name) {
    return '“$name” ficou de fora: não tem exercícios.';
  }

  @override
  String importNoticeSkippedRoutines(int count) {
    return 'Entradas ignoradas por não ter nome: $count.';
  }

  @override
  String importNoticeSkippedExercises(String name, int count) {
    return 'Exercícios ignorados em “$name” por não ter nome: $count.';
  }

  @override
  String importNoticeDuplicateName(String name) {
    return 'Você já tem uma rotina chamada “$name”. Esta é adicionada também.';
  }

  @override
  String get importSettingsSubtitle =>
      'Cole um plano e crie todas as rotinas de uma vez';

  @override
  String get exportTitle => 'Exportar rotinas';

  @override
  String get exportSettingsSubtitle =>
      'Salve uma cópia que você pode colar de volta';

  @override
  String get exportIntro =>
      'Estas são todas as suas rotinas, no mesmo formato que a tela de importar lê. Guarde em uma nota ou um arquivo: ao colar de volta, elas são recriadas com seus exercícios, séries, pesos e notas, aqui ou em um celular novo.';

  @override
  String get exportHistoryNote =>
      'Os treinos registrados não estão incluídos: aqui estão só as suas rotinas.';

  @override
  String exportSummary(int routineCount, int exerciseCount, int setCount) {
    return 'Rotinas: $routineCount · Exercícios: $exerciseCount · Séries: $setCount';
  }

  @override
  String get exportCopy => 'Copiar JSON';

  @override
  String get exportCopied =>
      'Rotinas copiadas. Cole em algum lugar onde possa guardá-las.';

  @override
  String get exportEmpty => 'Você ainda não tem rotinas para exportar.';

  @override
  String get exportError => 'Não foi possível ler suas rotinas. Tente de novo.';
}
