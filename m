Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96411CCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 02:05:56 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8009.1792289149048394442
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 19:05:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=f3PHZs2q;
 spf=pass (domain: gmail.com, ip: 209.85.216.49, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398b3c37877so658146a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 19:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792289148; x=1792893948; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7kFjqs3hwelBPIphHklXp5Cu36PGTOKNKVbcH/MaEFw=;
        b=f3PHZs2qfWfBskUbXGX6g94InBr4BLKOgI2zSEHFtQg+H+E0C2o8DHWXGLpZW8rPJ0
         wWK+sToMxG36oYAXNYGlWo4hfF9PKRaPyt0nAumDf+oD4S5HCkAjqSt77NlAWXQptoE6
         fgtPj278XkEHc3ONLlc/a9SVMNojRxH5CK0vvrj+LVim0C202vdxYJ0PTy/UfJa2M1Xf
         tAT2JvZlC/UdZrnmoWLnMQyp92A5eNoyP4ccWLwxCnFEKGxA3aj0ONfvsPDDDA3fI68+
         nDN7UiMmrSkQTQe/5lRQ/K2B/WlZOlTs93Y+x5DikY3KtHQWCqfeqRKZ6y+UGGYd9o9q
         DTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289148; x=1792893948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7kFjqs3hwelBPIphHklXp5Cu36PGTOKNKVbcH/MaEFw=;
        b=bwC16Ov5jaYJrRo1Df3qi2k/n4oy0I8Z9bWLHeF7QIMkA8BFtH1VXE83PZlCB6r1gD
         xaFwusc7RxJLrkyaItQJ48xaTVOlpBB11dCiTPI1A8qX7heNZbGuK3fTjZIr/Sp2AU9K
         ON4D+xUdktUyR59sEJ/sKVs0Q4xQpifO1N7/yTTW7ltcNPPL+btZfajN+s4KkfjgdYHg
         qWDtuzzlBPNnoa1sQQMjcIwuG23i+4Gjcr6LWsKJhFDnurVHDwwfTNlawU37+NRnac25
         n/W4TfDIw9gMu4bZynAKkUksEKRDLNfSF9foqxcRzLS5CguRNQ/Mbgc5x8y49yepXIU0
         HsNQ==
X-Gm-Message-State: AFq9FYIHNCFhs/GEWdD6s1DQ9T+c8zgd4p4xwSiz29d/r8NSMpKMWQf+
	fNEmQ3wEPeYJDZDKo7PNpwX08xjfu+fwzWrmSgnbt0LEmnwJu2ZV8m4sUI+EWY8t
X-Gm-Gg: AYBFou0ZdwwNjzk4Y6+fjc+WJfCFS2izaeufk7O4BnNklQNZNmPCZQjTAyYqCBq1ALH
	Ct8GzjuJuhlu9iSG1x+/RjKu2wOCnh7boIiU/IFdbYOUYbldA8h4mmvJtehMDguuKooe41a3Lhn
	AWtwCCx6QWEUxI8hJTzLbnIt0a8Dfu758tMGBG2agiNZt9B5womhO6P1e3w2mhiZNOPhHMIPw0q
	x+OVKup8ywzSBrrSYuI0GVZfikbbOc0t20A3Gfu4i42aH5Q+8qPkZCeV7cY/nO3bWTbFsDXcQ0W
	kzDVoKVrXDjONa4H0YRGebzZ/jYiTX+6TQrzWMntZkzDP2pR9cbBkdBxCcle8DXeWVN5e2LJVPK
	i3yAhLiuKx+ewAaN0x+DSRDgQgNnaoCe+MfzHOp2ATomCpAxBlpG0TDsCB2KSKZ4ChdGjnPK+O5
	A9+8z6CrB3HBVmP4qI07aZTrFwwtxMEz3/ltyRiNx+uTVSqZ373kkEaOG0wDqraUCa+KygzsIbL
	OkUZAyp1WOKtZDI7AfVvVCgERjncYg=
X-Received: by 2002:a17:90b:582d:b0:3ac:8897:7b98 with SMTP id 98e67ed59e1d1-3acef1455edmr3579754a91.32.1792289148330;
        Sat, 17 Oct 2026 19:05:48 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc98139ccsm5775584a91.0.2026.10.17.19.05.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 19:05:47 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 1/2] Don't let Bootstrap insert submitted data as HTML.
Date: Sat, 17 Oct 2026 19:03:54 -0700
Message-ID: <20261018020518.76802-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018020518.76802-1-tim.orling@konsulko.com>
References: <20261018020518.76802-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 02:05:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5067

The filter tooltips used html: true, and their titles hold the
submitted recipe and task, which bleach doesn't clean, so a report could
inject HTML (the CSP stopped scripts). Drop html: true, and build the
commit popover from DOM nodes so the commit is inserted as text.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Post/static/js/main.js       | 14 +++++++++++---
 Post/test.py                 | 35 +++++++++++++++++++++++++++++++++++
 templates/latest-errors.html |  7 +------
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/Post/static/js/main.js b/Post/static/js/main.js
index 5c07ad5..546aabe 100644
--- a/Post/static/js/main.js
+++ b/Post/static/js/main.js
@@ -219,9 +219,16 @@ $(document).ready(function(){
 
   $("#errors-table").show();
 
+  /* Insert the submitted commit as text, not HTML. */
   $('.commit > div').popover({
       placement:'left',
-      html: true
+      html: true,
+      content: function () {
+        var commit = $(this).attr('data-commit');
+        var link = $('<a href="#" class="filter visible" data-type="commit">Filter by commit</a>')
+          .attr('data-filter', commit);
+        return $('<div/>').append($('<span/>').text(commit), $('<p/>').append(link));
+      }
   });
 
   $(".recipe_version a.tooltip-me").tooltip();
@@ -267,8 +274,9 @@ $(document).ready(function(){
     e.stopPropagation();
   });
 
-  $(".icon-filter").tooltip({ container: 'body', html: true });
+  /* Titles hold submitted data: keep them text. */
+  $(".icon-filter").tooltip({ container: 'body' });
   // initialise the remove filter tooltips
-  $("th .btn-mini").tooltip({ container: 'body', html: true, title:'Clear filter' });
+  $("th .btn-mini").tooltip({ container: 'body', title:'Clear filter' });
 
 });
diff --git a/Post/test.py b/Post/test.py
index f48beec..0a358d1 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -432,6 +432,41 @@ class AccountPagesRemovedTest(TestCase):
         self.assertEqual(client.get("/admin/login/").status_code, 200)
 
 
+@override_settings(ALLOWED_HOSTS=["testhost"])
+class SubmittedHtmlTest(TestCase):
+    """Submitted data must only ever reach the page escaped."""
+
+    def submit(self, **fields):
+        with open("test-data/test-payload.json") as f:
+            payload = json.load(f)
+        payload.update(fields)
+        payload['failures'][0]['package'] = '<b>evil</b>-1.0'
+        payload['failures'][0]['task'] = 'do_<b>evil</b>'
+        client = Client(HTTP_HOST="testhost")
+        data = urllib.parse.urlencode({'data': json.dumps(payload)})
+        self.assertEqual(client.post("/ClientPost/", data, "application/json").status_code, 200)
+        return client, BuildFailure.objects.get()
+
+    def test_failure_fields_are_escaped(self):
+        client, bf = self.submit()
+        response = client.get("/Errors/Latest/")
+        self.assertNotContains(response, "<b>evil</b>")
+        self.assertContains(response, "Filter by &lt;b&gt;evil&lt;/b&gt;: do_&lt;b&gt;evil&lt;/b&gt;")
+
+    def test_commit_is_not_in_html_attributes(self):
+        client, bf = self.submit(branch_commit="master: <b>evil</b>")
+        response = client.get("/Errors/Latest/")
+        self.assertNotContains(response, "<b>evil</b>")
+        self.assertContains(response, 'data-commit="&lt;b&gt;evil&lt;/b&gt;"')
+        # With html enabled, Bootstrap inserts these as HTML.
+        self.assertNotContains(response, "data-content")
+        self.assertNotContains(response, "data-html")
+
+    def test_tooltips_are_not_html(self):
+        with open("Post/static/js/main.js") as f:
+            self.assertNotRegex(f.read(), r"tooltip\(\{[^}]*html: true")
+
+
 @patch("Post.management.commands.culldb.time.sleep")
 class CullDbTest(TestCase):
     def setUp(self):
diff --git a/templates/latest-errors.html b/templates/latest-errors.html
index 2080210..d9c2890 100644
--- a/templates/latest-errors.html
+++ b/templates/latest-errors.html
@@ -189,12 +189,7 @@
 
                 </td>
                 <td class="commit">
-                  <div class="btn" rel="popover"
-                      data-content='
-                      {{ build_fail.BUILD.COMMIT|escape}}
-                      <p><a href="#" class="filter visible" data-filter="{{build_fail.BUILD.COMMIT}}" data-type="commit" >Filter by commit</a>'
-                      data-html="true"
-                    >
+                  <div class="btn" rel="popover" data-commit="{{ build_fail.BUILD.COMMIT }}">
                     {{ build_fail.BUILD.COMMIT|truncatechars:10}}
 
                   </div>
-- 
2.56.0


