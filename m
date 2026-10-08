Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1832CA6007
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 15:01:31 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17681.1791471687310735707
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 Oct 2026 08:01:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VoUuKo+2;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: ticotimo@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b042c0759so2568051f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791471685; x=1792076485; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1W/Uj46+ZYhlK7hNog8OOUBBrfsr2ZBF6oUDDeHLLz0=;
        b=VoUuKo+2m+tfrOrnUZiAIFR8Rh6t/a25zJlJbvYxpDZcVssro10t1Ena0T6LX8uSns
         /5KS2ptPE6650X5dGTzobptFB0qWNkBjyaMNUulSWuvEYn40NcRW2gDIo1kxF9N2BOjG
         er3z5yFcJn7199j6M1gXq4wkaPwACnkY9HvJmBYhDH+Nbz6e/DAxeiRezT7NCFezKsH5
         1msnhpRJSHV1OmvwnYhQHlreE73XhCXn8EcZW7ix4ForX6GQkYvzg/xgJcHGhew5eZNe
         rP6i+206BhM/FXeV6aLEBuuladBtF7wPmVxQ3AotSPTq6SqsVkUKU4tW4ydPM3uNOGK5
         buGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471685; x=1792076485;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1W/Uj46+ZYhlK7hNog8OOUBBrfsr2ZBF6oUDDeHLLz0=;
        b=abIZ+vASCi6IFv1pEHvVtcAzH4cg35HKeiaQfANiZe9FDLtiv8a9KfNN8OUjUSBAgd
         /6i82zlXBMGN6Rdjojk5QPxt7DkmqtUdFXzR+8Deopb2kTZZOKhEdjudPlJVXQgwx/Va
         qUq3Lmkx5xjwka9WYMoS9aI7pOhUpsGH0Qg5TWCc3Tz9hnVvyjEuUjoxVBjhuxYP3Cty
         lpBStVSWHPYAJ5kBzy4y1q92yHuSJmbKabTT5hBAe/5FZbfTruuyqawC6LVw1Cpnm2i4
         uOg2Vaq2i3QaWb6gTVDRB88OnLz9HzwcTcewDaCoXn5JT3lEKXjmFdEmW59v4HdKvES+
         Os3w==
X-Gm-Message-State: AFq9FYIBwllZzN1SyC/DnxaCh7sxkBTLpMWvqvIvid+L4jHMTXnVvhrb
	qYar9QGbpBfp9FQkf0Nb+pGUBp/gzhYjeCLNupv0r59lI9Xyywj/70I6xvB/5unI
X-Gm-Gg: AYBFou11+DabueA+m+XTPnBKt5ULw8aDZqDxI+Z2ONfHxjMhaBLKdcfWpIXzXTytGNP
	8O3Ncd6lkraWyGTaolHdIJHNHv6503I2QARGtKTpbeen5ij/eshbgtwa8QRg7guBW4OjnqEqsVL
	peuNH8+SQUPAU4+A5D5Li+h8k9OZXCJ89RgM9NrUaLI5lCJuG7ekRhZpbD+NrLxNJls1sLkFJGK
	aXyoUXfAdu+LUs7yhPMb2YCgkRU8OlDHx9Gbb7MnTFwN/zTflhQa5JAydwhJC5zHLikYZfRPTTe
	g+ikymzht9kNi1zlMKEQaC71BcDX/6+CjtPzCnhgsPMrKLf4Va4ZiFIO71v22hujz03X+cjT8uE
	NYZ6JKgCLidZ5rBji3MfpOqMh2O5CfVHig23WWiD3QtT9RAkmy3nSH5RMQMUwKBBI9acl8515oJ
	RrYNxJO13iMpQfQg1BH3x/bIM/vSZAp41L8XJ75H5ZSMmza6ACB2Z7mTlxiVrfWA3dsdIj3Y3AS
	7G3zkGihi+voZ0hqf/nJrBNoIiS7ZQSIzpApuZ/xQhlSI1szg==
X-Received: by 2002:a05:6000:2912:b0:487:1256:ab80 with SMTP id ffacd0b85a97d-48c7288dbbcmr11086963f8f.57.1791471684654;
        Thu, 08 Oct 2026 08:01:24 -0700 (PDT)
Received: from localhost.localdomain (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db653184csm18945f8f.40.2026.10.08.08.01.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 08:01:21 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>,
	Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH] Add a Content Security Policy
Date: Thu,  8 Oct 2026 17:01:12 +0200
Message-ID: <20261008150114.30950-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 15:01:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4998

From: Michael Halstead <mhalstead@linuxfoundation.org>

Error reports contain user submitted build logs, machine names, recipe
names and so on, so add a strict Content Security Policy as a backstop
against cross site scripting.

Django 4.2 has no built in CSP support, so add a small middleware which
sends the policy from the new CONTENT_SECURITY_POLICY setting. The
default only allows resources served by the application itself. Setting
CONTENT_SECURITY_POLICY_REPORT_ONLY (CSP_REPORT_ONLY in the docker .env)
sends the policy as Content-Security-Policy-Report-Only instead.

The statistics charts relied on an inline script which jQuery executed
with eval. Embed the chart data with json_script and move the drawing
code into main.js. Also escape the tooltip text, which nvd3 inserts as
HTML, and URL encode the filter value when clicking a bar.

Replace inline style attributes with classes in custom.css and drop the
inline script blocks from the registration templates, which were never
rendered since base.html has no scripts block.

Document the policy in the README and add tests.

AI-Generated: Claude Opus 5.5
Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Post/middleware.py                            | 41 +++++++++++++
 Post/static/css/custom.css                    | 28 +++++++++
 Post/static/js/main.js                        | 59 ++++++++++++++++++
 Post/test.py                                  | 61 ++++++++++++++++++-
 Post/views.py                                 |  8 +--
 README                                        | 35 +++++++++++
 project/settings.py                           | 23 +++++++
 project/settings.py.docker                    | 23 +++++++
 templates/discretebarchart.html               | 49 +++------------
 templates/error-details.html                  |  4 +-
 templates/home.html                           | 52 +++-------------
 templates/latest-errors.html                  | 16 ++---
 templates/registration/login.html             |  9 ---
 .../registration/password_reset_confirm.html  |  9 ---
 .../registration/password_reset_form.html     |  9 ---
 templates/registration/registration_form.html |  9 ---
 16 files changed, 300 insertions(+), 135 deletions(-)
 create mode 100644 Post/middleware.py

diff --git a/Post/middleware.py b/Post/middleware.py
new file mode 100644
index 0000000..52ade71
--- /dev/null
+++ b/Post/middleware.py
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: MIT
+#
+# error-reporting-tool - middleware
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+
+from django.conf import settings
+
+
+class ContentSecurityPolicyMiddleware:
+    """Add a Content-Security-Policy header to every response.
+
+    The policy is read from settings.CONTENT_SECURITY_POLICY, a dict mapping
+    each directive to a list of sources (an empty list gives a directive with
+    no value, e.g. 'upgrade-insecure-requests'). When
+    settings.CONTENT_SECURITY_POLICY_REPORT_ONLY is True the policy is sent
+    as Content-Security-Policy-Report-Only instead, so violations are
+    reported by browsers but not blocked.
+    """
+
+    def __init__(self, get_response):
+        self.get_response = get_response
+
+        policy = getattr(settings, 'CONTENT_SECURITY_POLICY', None) or {}
+        self.policy = "; ".join(
+            " ".join([directive] + list(sources))
+            for directive, sources in policy.items())
+
+        if getattr(settings, 'CONTENT_SECURITY_POLICY_REPORT_ONLY', False):
+            self.header = 'Content-Security-Policy-Report-Only'
+        else:
+            self.header = 'Content-Security-Policy'
+
+    def __call__(self, request):
+        response = self.get_response(request)
+
+        # Leave alone any policy a view has set itself
+        if self.policy and self.header not in response:
+            response[self.header] = self.policy
+
+        return response
diff --git a/Post/static/css/custom.css b/Post/static/css/custom.css
index b640ad5..5912a23 100644
--- a/Post/static/css/custom.css
+++ b/Post/static/css/custom.css
@@ -129,3 +129,31 @@ th a, th span {
         word-wrap: break-word;
         word-break: break-all;
 }
+
+/* Styles below replace inline style attributes, which the Content
+ * Security Policy (style-src 'self') does not allow.
+ */
+.filter.visible, .sorting-arrows.visible {
+        visibility: visible;
+}
+
+.back-btn {
+        margin-top: 7px;
+}
+
+.details-title {
+        margin-left: 60px;
+}
+
+.pagesize-label {
+        padding-top: 5px;
+}
+
+select.pagesize {
+        margin-top: 5px;
+        margin-bottom: 0px;
+}
+
+.chart-svg {
+        height: 400px;
+}
diff --git a/Post/static/js/main.js b/Post/static/js/main.js
index 3eca147..5c07ad5 100644
--- a/Post/static/js/main.js
+++ b/Post/static/js/main.js
@@ -42,8 +42,67 @@ function dumpsUrlParams(obj) {
   return str.substr(0,str.length-1);
 };
 
+/* Escape text for use in HTML strings, e.g. nvd3 tooltips which are
+ * inserted with innerHTML */
+function escapeHtml(text) {
+  return $('<div/>').text(String(text)).html();
+}
+
+/* Draw a statistics bar chart from a templates/discretebarchart.html
+ * fragment. The data is embedded as a JSON script element rather than
+ * inline JavaScript so that it works under the Content Security Policy.
+ */
+function renderDiscreteBarChart(container) {
+  var data = JSON.parse(container.find('script[type="application/json"]').text());
+  var filterUrl = container.data('filter-url');
+  var filterType = container.data('filter-type');
+
+  nv.addGraph(function() {
+    var chart = nv.models.discreteBarChart();
+
+    chart.staggerLabels(true);
+    chart.yAxis.tickFormat(d3.format(',.0f'));
+    /* Ellipsize long labels */
+    chart.xAxis.tickFormat(function(label) {
+      if (label.length >= 14)
+        return label.substring(0,13) + '\u2026';
+
+      return label;
+    });
+
+    chart.tooltipContent(function(key, x, y, e) {
+      return escapeHtml(e.point.x) + ": " + escapeHtml(e.point.y);
+    });
+
+    chart.discretebar.dispatch.on('elementClick', function(e) {
+      window.location.href = filterUrl + '?filter=' +
+        encodeURIComponent(e.point.x) + '&type=' + encodeURIComponent(filterType);
+    });
+
+    /* TODO nv.utils.windowResize(chart.update); */
+
+    d3.select(container.find('svg')[0])
+    .datum(data)
+    .transition(350)
+    .attr('height', 400)
+    .call(chart);
+  });
+}
+
 $(document).ready(function(){
 
+  /* Load the statistics charts */
+  $("[data-stats-url]").each(function () {
+    var thumbnail = $(this);
+    $.get(thumbnail.data('stats-url'), function (html) {
+      var chart = $(html).filter('.discrete-bar-chart');
+      if (chart.length == 0)
+        return;
+      thumbnail.append(chart);
+      renderDiscreteBarChart(chart);
+    });
+  });
+
   /* Use json encoding for cookie content */
   $.cookie.json = true;
 
diff --git a/Post/test.py b/Post/test.py
index 5acb68e..57cc2c1 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -2,7 +2,7 @@ import unittest
 import urllib.request, urllib.parse, urllib.error
 import json
 import re
-from django.test import Client
+from django.test import Client, override_settings
 from Post.models import BuildFailure, Build
 
 #Delete the data between tests
@@ -241,3 +241,62 @@ class SimpleTest(unittest.TestCase):
 
         response = self.client.get("/Errors/Details/9898989898/")
         self.assertEqual(response.status_code, 200)
+
+class CSPTest(unittest.TestCase):
+    def setUp(self):
+        self.client = Client(HTTP_HOST="testhost")
+
+    def test_csp_header(self):
+        for url in ('/Statistics/', '/Errors/Latest/'):
+            response = self.client.get(url)
+            self.assertEqual(response.status_code, 200)
+            csp = response['Content-Security-Policy']
+            self.assertIn("script-src 'self'", csp)
+            self.assertIn("style-src 'self'", csp)
+            self.assertIn("object-src 'none'", csp)
+            self.assertNotIn("unsafe-inline", csp)
+            self.assertNotIn("unsafe-eval", csp)
+
+    def test_csp_report_only(self):
+        with override_settings(CONTENT_SECURITY_POLICY_REPORT_ONLY=True):
+            # New client so the middleware picks up the setting
+            response = Client(HTTP_HOST="testhost").get('/Statistics/')
+        self.assertIn('Content-Security-Policy-Report-Only', response)
+        self.assertNotIn('Content-Security-Policy', response)
+
+    def test_csp_disabled(self):
+        with override_settings(CONTENT_SECURITY_POLICY=None):
+            response = Client(HTTP_HOST="testhost").get('/Statistics/')
+        self.assertNotIn('Content-Security-Policy', response)
+
+    def test_no_inline_script_or_style(self):
+        Build.objects.all().delete()
+
+        with open("test-data/test-payload.json") as f:
+            data = urllib.parse.urlencode({'data': f.read()})
+        response = self.client.post("/ClientPost/", data, "application/json")
+        self.assertEqual(response.status_code, 200)
+
+        build = Build.objects.get()
+        failure = BuildFailure.objects.get()
+        urls = ['/Statistics/',
+                '/Errors/Statistics/MACHINE/',
+                '/Errors/Latest/',
+                '/Errors/Build/%d/' % build.id,
+                '/Errors/Details/%d/' % failure.id]
+
+        for url in urls:
+            response = self.client.get(url)
+            self.assertEqual(response.status_code, 200)
+            content = response.content.decode('utf-8')
+            self.assertIsNone(re.search(r'\sstyle\s*=', content), url)
+            # Only external scripts and non-executed JSON data are allowed
+            for script in re.findall(r'<script[^>]*>', content):
+                self.assertTrue(re.search(r'\ssrc\s*=', script) or
+                                'type="application/json"' in script,
+                                "%s: %s" % (url, script))
+
+        response = self.client.get('/Errors/Statistics/MACHINE/')
+        self.assertIn(build.MACHINE, response.content.decode('utf-8'))
+
+        Build.objects.all().delete()
diff --git a/Post/views.py b/Post/views.py
index 89a57cf..add68d5 100644
--- a/Post/views.py
+++ b/Post/views.py
@@ -296,11 +296,9 @@ def chart(request, template_name, key):
     if (alldata == {}):
         return HttpResponse("")
 
-    data = json.dumps([{ 'values': list(alldata)}])
-    # Replace MACHINE with x and dcount with value
-    # We do this in the string as it's more efficient
-    data = data.replace(key, "x")
-    data = data.replace("dcount", "y")
+    # Rename e.g. MACHINE to x and dcount to y for nvd3
+    data = [{ 'values': [{ 'x': item[key], 'y': item['dcount'] }
+                         for item in alldata] }]
 
     context = { 'data' : data,
                'chart_id': key,
diff --git a/README b/README
index d56fdbd..04f88d2 100644
--- a/README
+++ b/README
@@ -38,6 +38,41 @@ In order to send an error report to the server, run the "send-error-report file_
 
 For more information on error reporting and log collection see: http://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#using-the-error-reporting-tool
 
+Content Security Policy
+-----------------------
+
+Every response carries a Content-Security-Policy header, added by
+Post.middleware.ContentSecurityPolicyMiddleware. The default policy in
+settings.py only allows resources served by the application itself:
+
+  default-src 'self'; script-src 'self'; style-src 'self';
+  img-src 'self' data:; font-src 'self'; connect-src 'self';
+  object-src 'none'; base-uri 'self'; form-action 'self';
+  frame-ancestors 'none'
+
+Inline scripts, inline event handlers (onclick=...), style attributes and
+eval() are blocked. When changing templates put JavaScript in
+Post/static/js/main.js and CSS in Post/static/css/custom.css. To pass data
+from a view to JavaScript use the json_script template filter or data-*
+attributes.
+
+The policy is configured with CONTENT_SECURITY_POLICY, a dict mapping each
+directive to a list of sources. For example, to also load images from a CDN
+and have browsers report violations:
+
+  CONTENT_SECURITY_POLICY['img-src'] = ["'self'", "data:", "https://cdn.example.com"]
+  CONTENT_SECURITY_POLICY['report-uri'] = ["https://example.com/csp-report"]
+
+Set CONTENT_SECURITY_POLICY = None to disable the header. Set
+CONTENT_SECURITY_POLICY_REPORT_ONLY = True to send the policy as
+Content-Security-Policy-Report-Only, so violations are reported but not
+blocked; this is useful when trying out a policy change. With the docker
+setup set CSP_REPORT_ONLY=1 in .env to do the same.
+
+If the web server in front of Django (Apache, nginx) also sets a
+Content-Security-Policy header, browsers enforce both, so set it in one place.
+The Django admin pages may lose some minor cosmetic styling under this policy.
+
 Maintenance
 -----------
 
diff --git a/project/settings.py b/project/settings.py
index 33d8ef9..1ec6891 100644
--- a/project/settings.py
+++ b/project/settings.py
@@ -48,6 +48,28 @@ MAX_UPLOAD_SIZE = "5242880"
 # Tolerance value to determine the distance between similar errors
 SIMILAR_FAILURE_DISTANCE = 10
 
+# Content Security Policy sent with every response by
+# Post.middleware.ContentSecurityPolicyMiddleware. Each directive maps to a
+# list of sources. All scripts, styles, fonts and images are served locally,
+# so no inline scripts or style attributes are allowed. Set to None to
+# disable the header.
+CONTENT_SECURITY_POLICY = {
+    'default-src': ["'self'"],
+    'script-src': ["'self'"],
+    'style-src': ["'self'"],
+    'img-src': ["'self'", "data:"],
+    'font-src': ["'self'"],
+    'connect-src': ["'self'"],
+    'object-src': ["'none'"],
+    'base-uri': ["'self'"],
+    'form-action': ["'self'"],
+    'frame-ancestors': ["'none'"],
+}
+
+# Send the policy as Content-Security-Policy-Report-Only so violations are
+# reported by browsers but not blocked. Useful when changing the policy.
+CONTENT_SECURITY_POLICY_REPORT_ONLY = False
+
 
 # Local time zone for this installation. Choices can be found here:
 # http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
@@ -120,6 +142,7 @@ MIDDLEWARE = [
     'django.contrib.sessions.middleware.SessionMiddleware',
     'django.contrib.auth.middleware.AuthenticationMiddleware',
     'django.contrib.messages.middleware.MessageMiddleware',
+    'Post.middleware.ContentSecurityPolicyMiddleware',
     # Uncomment the next line for simple clickjacking protection:
     # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
 ]
diff --git a/project/settings.py.docker b/project/settings.py.docker
index 4dcb58d..b7ff669 100644
--- a/project/settings.py.docker
+++ b/project/settings.py.docker
@@ -42,6 +42,28 @@ MAX_UPLOAD_SIZE = "5242880"
 # Tolerance value to determine the distance between similar errors
 SIMILAR_FAILURE_DISTANCE = 10
 
+# Content Security Policy sent with every response by
+# Post.middleware.ContentSecurityPolicyMiddleware. Each directive maps to a
+# list of sources. All scripts, styles, fonts and images are served locally,
+# so no inline scripts or style attributes are allowed. Set to None to
+# disable the header.
+CONTENT_SECURITY_POLICY = {
+    'default-src': ["'self'"],
+    'script-src': ["'self'"],
+    'style-src': ["'self'"],
+    'img-src': ["'self'", "data:"],
+    'font-src': ["'self'"],
+    'connect-src': ["'self'"],
+    'object-src': ["'none'"],
+    'base-uri': ["'self'"],
+    'form-action': ["'self'"],
+    'frame-ancestors': ["'none'"],
+}
+
+# Send the policy as Content-Security-Policy-Report-Only so violations are
+# reported by browsers but not blocked. Useful when changing the policy.
+CONTENT_SECURITY_POLICY_REPORT_ONLY = os.environ.get('CSP_REPORT_ONLY', '').lower() in ('1', 'true', 'yes')
+
 
 # Local time zone for this installation. Choices can be found here:
 # http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
@@ -114,6 +136,7 @@ MIDDLEWARE = [
     'django.contrib.sessions.middleware.SessionMiddleware',
     'django.contrib.auth.middleware.AuthenticationMiddleware',
     'django.contrib.messages.middleware.MessageMiddleware',
+    'Post.middleware.ContentSecurityPolicyMiddleware',
     # Uncomment the next line for simple clickjacking protection:
     # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
 ]
diff --git a/templates/discretebarchart.html b/templates/discretebarchart.html
index c132d97..3f1e9ee 100644
--- a/templates/discretebarchart.html
+++ b/templates/discretebarchart.html
@@ -1,39 +1,10 @@
-<div id="{{ chart_id }}"><svg style="height:400px;"></svg></div>
-<script type="text/javascript">
-
-var data_{{ chart_id }}=JSON.parse("{{ data|escapejs }}");
-
-nv.addGraph(function() {
-   var chart = nv.models.discreteBarChart();
-
-   chart.staggerLabels(true);
-   chart.yAxis.tickFormat(d3.format(',.0f'));
-   /* Ellipsize long labels */
-   chart.xAxis.tickFormat(function(label) {
-     if (label.length >= 14)
-       return label.tooltip = label.substring(0,13) + '…';
-
-     return label
-   });
-
-   chart.tooltipContent(function(key, y, e, graph) {
-     var x = String(graph.point.x);
-     var y = String(graph.point.y);
-
-     tooltip_str = x + ": " +y;
-     d3.selectAll('.discreteBar').on('click', function() {
-       window.location.href='{% url 'latest_errors' %}?filter='+x+'&type={{chart_id|lower}}';
-     });
-     return tooltip_str;
-   });
-
-   /* TODO nv.utils.windowResize(chart.update); */
-
-   d3.select('#{{ chart_id }} svg')
-   .datum(data_{{ chart_id }})
-   .transition(350)
-   .attr('height', 400)
-   .call(chart);
-
- });
-</script>
+{% comment %}
+Rendered by Post/static/js/main.js (renderDiscreteBarChart). No inline
+script here: the Content Security Policy only allows scripts from 'self'.
+{% endcomment %}
+<div class="discrete-bar-chart"
+     data-filter-url="{% url 'latest_errors' %}"
+     data-filter-type="{{ chart_id|lower }}">
+  {{ data|json_script }}
+  <svg class="chart-svg"></svg>
+</div>
diff --git a/templates/error-details.html b/templates/error-details.html
index 35bf0aa..abdc2d1 100644
--- a/templates/error-details.html
+++ b/templates/error-details.html
@@ -6,10 +6,10 @@
     <div class="alert"><p>Build id not found</p></div>
   {% else %}
   <div class="page-header">
-    <a class="btn pull-left back-btn" style="margin-top:7px;" href="#">
+    <a class="btn pull-left back-btn" href="#">
       <i class="icon-arrow-left"></i>
     </a>
-    <h1 style="margin-left:60px;">
+    <h1 class="details-title">
         {% if detail.BUILD.ERROR_TYPE == error_types.RECIPE %}
         {{detail.RECIPE}}-{{detail.RECIPE_VERSION}}
         {% endif %}
diff --git a/templates/home.html b/templates/home.html
index 15176a3..938d371 100644
--- a/templates/home.html
+++ b/templates/home.html
@@ -8,13 +8,13 @@
             <ul class="thumbnails">
               <li class="span6">
                 <h2>By machine</h2>
-                <div class="thumbnail" id="MACHINE">
+                <div class="thumbnail" id="MACHINE" data-stats-url="{% url "statistics" "MACHINE" %}">
 
                 </div>
               </li>
               <li class="span6">
                 <h2>By recipe</h2>
-                <div class="thumbnail" id="RECIPE">
+                <div class="thumbnail" id="RECIPE" data-stats-url="{% url "statistics" "RECIPE" %}">
                 </div>
               </li>
             </ul>
@@ -23,12 +23,12 @@
             <ul class="thumbnails">
               <li class="span6">
                 <h2>By target</h2>
-                <div class="thumbnail" id="TARGET">
+                <div class="thumbnail" id="TARGET" data-stats-url="{% url "statistics" "TARGET" %}">
                 </div>
               </li>
               <li class="span6">
                 <h2>By distro</h2>
-                <div class="thumbnail" id="DISTRO">
+                <div class="thumbnail" id="DISTRO" data-stats-url="{% url "statistics" "DISTRO" %}">
                 </div>
               </li>
             </ul>
@@ -37,12 +37,12 @@
             <ul class="thumbnails">
               <li class="span6">
                 <h2>By branch</h2>
-                <div class="thumbnail" id="BRANCH">
+                <div class="thumbnail" id="BRANCH" data-stats-url="{% url "statistics" "BRANCH" %}">
                 </div>
               </li>
               <li class="span6">
                 <h2>By commit</h2>
-                <div class="thumbnail" id="COMMIT">
+                <div class="thumbnail" id="COMMIT" data-stats-url="{% url "statistics" "COMMIT" %}">
                 </div>
               </li>
             </ul>
@@ -51,52 +51,16 @@
             <ul class="thumbnails">
               <li class="span6">
                 <h2>By target system</h2>
-                <div class="thumbnail" id="TARGET_SYS">
+                <div class="thumbnail" id="TARGET_SYS" data-stats-url="{% url "statistics" "TARGET_SYS" %}">
                 </div>
               </li>
               <li class="span6">
                 <h2>By host distro</h2>
-                <div class="thumbnail" id="NATIVELSBSTRING">
+                <div class="thumbnail" id="NATIVELSBSTRING" data-stats-url="{% url "statistics" "NATIVELSBSTRING" %}">
                 </div>
               </li>
             </ul>
           </div>
-          <script type="text/javascript">
-            $(document).ready(function () {
-              $.get('{% url "statistics" "MACHINE" %}', function(data){
-                $("#MACHINE").append (data);
-              });
-
-              $.get('{% url "statistics" "RECIPE" %}', function(data){
-                $("#RECIPE").append (data);
-              });
-
-              $.get('{% url "statistics" "TARGET" %}', function(data){
-                $("#TARGET").append (data);
-              });
-
-              $.get('{% url "statistics" "DISTRO" %}', function(data){
-                $("#DISTRO").append (data);
-              });
-
-              $.get('{% url "statistics" "BRANCH" %}', function(data){
-                $("#BRANCH").append (data);
-              });
-
-              $.get('{% url "statistics" "COMMIT" %}', function(data){
-                $("#COMMIT").append (data);
-              });
-
-              $.get('{% url "statistics" "TARGET_SYS" %}', function(data){
-                $("#TARGET_SYS").append (data);
-              });
-
-              $.get('{% url "statistics" "NATIVELSBSTRING" %}', function(data){
-                $("#NATIVELSBSTRING").append (data);
-              });
-
-            }); /* End onLoad */
-          </script>
 
         </div>
       </div>   <!-- end of tab-content -->
diff --git a/templates/latest-errors.html b/templates/latest-errors.html
index b9f081e..2080210 100644
--- a/templates/latest-errors.html
+++ b/templates/latest-errors.html
@@ -40,8 +40,8 @@
       {% endif %}
 
       <div class="pull-right">
-        <span class="help-inline" style="padding-top:5px;">Show rows: </span>
-        <select style="margin-top:5px;margin-bottom:0px;" class="input-mini pagesize">
+        <span class="help-inline pagesize-label">Show rows: </span>
+        <select class="input-mini pagesize">
           {% with "10 25 50 100 150" as list%}
           {% for i in list.split %}
           {% if request.session.limit == i|add:0 %}
@@ -93,10 +93,10 @@
 
                   {% if request.GET.order_by == "-"|add:col.field %}
                   <a href="#" class="sort-col sorted" data-order-by="{{col.field}}" >{{col.name}}</a>
-                  <span class="sorting-arrows" style="visibility: visible">&#9650</span>
+                  <span class="sorting-arrows visible">&#9650</span>
                   {% else %}
                   <a href="#" class="sort-col sorted" data-order-by="-{{col.field}}" >{{col.name}}</a>
-                   <span class="sorting-arrows" style="visibility: visible">&#9660</span>
+                   <span class="sorting-arrows visible">&#9660</span>
                    {% endif %}
                 {% else %}
                 {# default case is sorted by submitted_on #}
@@ -105,7 +105,7 @@
 
                   {% if col.clclass == "submitted_on" and not request.GET.order_by %}
                    <a href="#" class="sort-col sorted" data-order-by="-{{col.field}}" >{{col.name}}</a>
-                   <span class="sorting-arrows" style="visibility: visible">&#9660</span>
+                   <span class="sorting-arrows visible">&#9660</span>
 
                   {% elif col.clclass == "failure" %}
                   {{col.name}}
@@ -192,7 +192,7 @@
                   <div class="btn" rel="popover"
                       data-content='
                       {{ build_fail.BUILD.COMMIT|escape}}
-                      <p><a href="#" class="filter" style="visibility: visible" data-filter="{{build_fail.BUILD.COMMIT}}" data-type="commit" >Filter by commit</a>'
+                      <p><a href="#" class="filter visible" data-filter="{{build_fail.BUILD.COMMIT}}" data-type="commit" >Filter by commit</a>'
                       data-html="true"
                     >
                     {{ build_fail.BUILD.COMMIT|truncatechars:10}}
@@ -240,8 +240,8 @@
               {%endif%}
             </ul>
             <div class="pull-right">
-              <span class="help-inline" style="padding-top:5px;">Show rows:</span>
-              <select style="margin-top:5px;margin-bottom:0px;" class="input-mini pagesize">
+              <span class="help-inline pagesize-label">Show rows:</span>
+              <select class="input-mini pagesize">
                 {% with "10 25 50 100 150" as list%}
                 {% for i in list.split %}
                 {% if request.session.limit == i|add:0 %}
diff --git a/templates/registration/login.html b/templates/registration/login.html
index b8c1655..a6ae44f 100644
--- a/templates/registration/login.html
+++ b/templates/registration/login.html
@@ -16,12 +16,3 @@
 <p>{% trans "Forgot password" %}? <a href="{% url "auth_password_reset" %}">{% trans "Reset it" %}</a>!</p>
 <p>{% trans "Don't have an account" %}? <a href="{% url "registration_register" %}">{% trans "Create one now" %}</a>!</p>
 {% endblock %}
-
-
-{% block scripts %}
-<script>
-    $(document).ready(function() {
-        $("#login_form input:text, #login_form textarea").first().focus();
-    });
-</script>
-{% endblock %}
diff --git a/templates/registration/password_reset_confirm.html b/templates/registration/password_reset_confirm.html
index 09fc9c1..186ece5 100644
--- a/templates/registration/password_reset_confirm.html
+++ b/templates/registration/password_reset_confirm.html
@@ -19,12 +19,3 @@
 {% endif %}
 
 {% endblock %}
-
-
-{% block scripts %}
-<script>
-    $(document).ready(function() {
-        $("#password_form input:text, #password_form textarea").first().focus();
-    });
-</script>
-{% endblock %}
diff --git a/templates/registration/password_reset_form.html b/templates/registration/password_reset_form.html
index 1339756..067f15e 100644
--- a/templates/registration/password_reset_form.html
+++ b/templates/registration/password_reset_form.html
@@ -12,12 +12,3 @@
   {% csrf_token %}
 </form>
 {% endblock %}
-
-
-{% block scripts %}
-<script>
-    $(document).ready(function() {
-        $("#password_form input:text, #password_form textarea").first().focus();
-    });
-</script>
-{% endblock %}
diff --git a/templates/registration/registration_form.html b/templates/registration/registration_form.html
index 1f76ddb..32cb55b 100644
--- a/templates/registration/registration_form.html
+++ b/templates/registration/registration_form.html
@@ -13,12 +13,3 @@
   {% csrf_token %}
 </form>
 {% endblock %}
-
-
-{% block scripts %}
-<script>
-    $(document).ready(function() {
-        $("#registration_form input:text, #registration_form textarea").first().focus();
-    });
-</script>
-{% endblock %}
-- 
2.56.0


