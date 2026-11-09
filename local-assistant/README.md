# Zero Discrete Local Assistant

واجهة محادثة محلية مبنية على OpenCode وOllama، دون رسوم API عند استخدام النماذج المحلية.

شغّل Start-Assistant.cmd ثم افتح http://127.0.0.1:4096 . يبقى الجهاز مشغلاً أثناء الاستخدام.
النموذج الافتراضي Qwen3.5 4B يدعم الصور والأدوات. نموذج Qwen3-Coder 30B مخصص للكود وأثقل على كرت 8GB؛ لا يدعم الصور.
لا يوجد ربط Studio مباشر حتى الآن. دعم MCP في البرنامج لا يعني أن Studio اتصل فعلياً.
ملخص المشروع في PROJECT-HANDOFF.md. الملفات الكبيرة تبقى في مسار المشروع الأصلي ولا تُنسخ إلى Git.
راجع طلبات تنفيذ الأوامر والتعديل قبل قبولها. لا توجد مفاتيح سحابية مضمنة.

## Upstream
- https://github.com/anomalyco/opencode
- https://github.com/ollama/ollama
- https://ollama.com/library/qwen3.5
- https://ollama.com/library/qwen3-coder

Local integration files are MIT licensed. Upstream software and model licenses remain applicable.
