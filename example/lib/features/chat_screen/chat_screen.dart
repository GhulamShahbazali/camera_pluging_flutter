// ignore_for_file: prefer_single_quotes, document_ignores, prefer_int_literals, eol_at_end_of_file

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import '../../../core/widgets/ultrascan4d.dart';
import '../../../core/widgets/message_cards.dart';
import '../../../core/constants/ui/app_colors.dart';
import '../../../core/widgets/background_container.dart';
import '../../../core/constants/ui/app_text_styles.dart';
import 'package:usb_camera_plugin_example/core/widgets/inputs/send_text_field.dart';

class ChatMessage {
  final String message;
  final DateTime timestamp;
  final bool isSender;

  ChatMessage({
    required this.message,
    required this.timestamp,
    required this.isSender,
  });
}

class ChatScreen extends StatefulWidget {
  final String? initialQuestion;
  final String? geminiApiKey;
  final String? systemInstruction;
  final Map<String, dynamic>? dataContext;

  const ChatScreen({
    super.key,
    this.initialQuestion,
    this.geminiApiKey,
    this.systemInstruction,
    this.dataContext,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController questionController;
  late final ScrollController scrollController;
  Size? _fixedScreenSize;
  final List<ChatMessage> messages = [];
  bool _isLoadingResponse = false;
  bool _isGeminiInitialized = false;

  @override
  void initState() {
    super.initState();
    questionController = TextEditingController();
    scrollController = ScrollController();

    // Initialize Gemini if API key is provided
    if (widget.geminiApiKey != null && widget.geminiApiKey!.isNotEmpty) {
      log('widget.geminiApiKey: ${widget.geminiApiKey}');
      try {
        Gemini.init(apiKey: widget.geminiApiKey!);
        _isGeminiInitialized = true;
      } catch (e) {
        log('Failed to initialize Gemini: $e');
        _isGeminiInitialized = false;
      }
    }

    // Send initial question if provided
    if (widget.initialQuestion != null && widget.initialQuestion!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _sendMessage(widget.initialQuestion!);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Capture screen size only once when widget first builds
    _fixedScreenSize ??= MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    questionController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    if (_isLoadingResponse) return;

    final userMessage = text.trim();

    // Add user message
    setState(() {
      messages.add(
        ChatMessage(
          message: userMessage,
          timestamp: DateTime.now(),
          isSender: true,
        ),
      );
      _isLoadingResponse = true;
    });

    _scrollToBottom();

    // Clear input field
    questionController.clear();

    // Add "Thinking..." message
    final thinkingIndex = messages.length;
    setState(() {
      messages.add(
        ChatMessage(
          message: 'Thinking...',
          timestamp: DateTime.now(),
          isSender: false,
        ),
      );
    });
    _scrollToBottom();

    // Get response from Gemini API or fallback to dummy reply
    String responseText;
    if (_isGeminiInitialized) {
      try {
        // Build prompt using system instruction and data context from API
        final StringBuffer promptBuffer = StringBuffer();

        // Add system instruction if provided
        if (widget.systemInstruction != null &&
            widget.systemInstruction!.isNotEmpty) {
          promptBuffer.writeln(widget.systemInstruction!);
        }

        // Add data context if provided
        if (widget.dataContext != null && widget.dataContext!.isNotEmpty) {
          final dataContextJson = const JsonEncoder.withIndent(
            '  ',
          ).convert(widget.dataContext);
          promptBuffer.writeln(
            '\n=== INFORMACIÓN TÉCNICA Y CLÍNICA DISPONIBLE ===',
          );
          promptBuffer.writeln(dataContextJson);
          promptBuffer.writeln(
            '=== FIN DE LA INFORMACIÓN TÉCNICA Y CLÍNICA ===\n',
          );
        }

        // Add user question
        promptBuffer.writeln('Consulta del usuario: $userMessage');
        promptBuffer.writeln(
          '\nProporciona una respuesta completa y precisa basada únicamente en la información proporcionada.',
        );

        final prompt = promptBuffer.toString();

        // Generate response using flutter_gemini
        final response = await Gemini.instance.prompt(
          parts: [Part.text(prompt)],
        );

        responseText = response?.output ?? _getFallbackReply(userMessage);
      } catch (e) {
        log("Gemini API Error: $e");
        if (mounted) {
          responseText =
              "I apologize, but I'm experiencing technical difficulties. Please try asking your hair and scalp health question again. Remember, I can help with:\n\n• Hair and scalp health analysis\n• Understanding scan results\n• Hair loss conditions and treatments\n• Scalp conditions and care\n• Hair care routines and maintenance\n• General trichology questions";
        } else {
          responseText = _getFallbackReply(userMessage);
        }
      }
    } else {
      responseText = _getFallbackReply(userMessage);
    }

    if (mounted) {
      // Replace "Thinking..." message with actual response
      setState(() {
        messages[thinkingIndex] = ChatMessage(
          message: responseText,
          timestamp: DateTime.now(),
          isSender: false,
        );
        _isLoadingResponse = false;
      });

      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getFallbackReply(String userMessage) {
    // Fallback replies when Gemini API is not available
    final lowerMessage = userMessage.toLowerCase();

    if (lowerMessage.contains('frecuencia') ||
        lowerMessage.contains('escaneo') ||
        lowerMessage.contains('scan')) {
      return 'Se recomienda escanear el cabello entre una y dos veces por semana para controlar su estado y obtener resultados consistentes. Si se está monitoreando el progreso o siguiendo un tratamiento, escanearlo cada tres o cuatro días es suficiente. Para obtener lecturas más precisas, es recomendable escanear siempre con la misma iluminación y en la misma zona.';
    } else if (lowerMessage.contains('normal') ||
        lowerMessage.contains('estado')) {
      return 'El estado de su cabello puede variar según múltiples factores. Para una evaluación precisa, le recomiendo realizar un escaneo completo y revisar los resultados detallados. Los análisis periódicos ayudarán a identificar cambios y tendencias en la salud capilar.';
    } else if (lowerMessage.contains('tratamiento')) {
      return 'Los tratamientos capilares deben ser monitoreados regularmente mediante escaneos. Se recomienda realizar un escaneo antes de iniciar el tratamiento y luego seguimientos cada semana para evaluar la efectividad y ajustar según sea necesario.';
    } else {
      return 'Gracias por su consulta. Para brindarle una respuesta más precisa y personalizada, le recomiendo realizar un escaneo completo de su cabello. Los datos obtenidos me permitirán ofrecerle recomendaciones específicas basadas en el estado actual de su cabello.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // Use fixed screen size that was captured on first build
    final screenSize = _fixedScreenSize ?? mediaQuery.size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          // Fixed background using captured screen size - won't resize with keyboard
          Positioned(
            top: 0,
            left: 0,
            width: screenSize.width,
            height: screenSize.height,
            child: BackgroundContainer(child: const SizedBox()),
          ),
          // Scrollable content with keyboard padding
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('protocol'.tr, style: AppTextStyles.heading4),
                            Transform.translate(
                              offset: const Offset(0, -8),
                              child: Text(
                                'and_result'.tr,
                                style: AppTextStyles.heading3.copyWith(
                                  color: AppColors.yellowColor,
                                ),
                              ),
                            ),
                            const Ultrascan4d(),
                          ],
                        ),
                        // Messages list
                        ...messages.map((msg) {
                          if (msg.isSender) {
                            return SenderMessageCard(
                              message: msg.message,
                              timestamp: _formatTime(msg.timestamp),
                            );
                          } else {
                            return ReplierMessageCard(
                              message: msg.message,
                              timestamp: _formatTime(msg.timestamp),
                            );
                          }
                        }).toList(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                // Add padding for keyboard
                Padding(
                  padding: EdgeInsets.only(
                    bottom: mediaQuery.viewInsets.bottom,
                  ),
                  child: SendTextField(
                    controller: questionController,
                    enabled: !_isLoadingResponse,
                    isLoading: _isLoadingResponse,
                    onSend: () => _sendMessage(questionController.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
