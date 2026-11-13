Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1894.1794612503841577214
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 15:28:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=KF7QWq61;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso800634a91.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 15:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794612503; x=1795217303; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hWpY8ysClDJKuUZZH6Xd/IZG6FdZARbe1+6Y0vXefT4=;
        b=KF7QWq61Oznfl/6BblCkFo5mM87REm00xq22qnFZD+w9+fhX4whV3RAt8q8AxhhKFF
         a956CbgFZanrqzxsp6/lnAm8ca689T+wOcKfcfN4KSUnqHSasLY+YqVTeEn04MyzdW/Q
         0nTm+3zGG2xLvEkcK5i3mJhZuhsNPyTorjp7EBu9MOE7OKYib1TxRqAqpCzvASt4G7C+
         1d8IEoeW8q1C8jahq0vmWbjtb2rEQoAb1FFyGS9fwJM+6/xFkR6jadPAjAHGTdvxz/TM
         2DgBxS+krz7R7K8+fCSdubsB02p5nK2vyACsweIX25u/rVuMG0LkbQXwEXYKnksn7bBw
         gZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794612503; x=1795217303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hWpY8ysClDJKuUZZH6Xd/IZG6FdZARbe1+6Y0vXefT4=;
        b=JUDvSthZdcjLp9Q1qfg4EeCzlljUOGx4OUot0wn6KclgJWwtZy1Vt7rw6rVRfjy0ed
         /y8Ll/uY6pUBkA9nrNLrbguVZ6KlYDsm6hu4EicnpSFH8wBloO3I2CQH4uA6A1RRAe9+
         /AYzD8v8tbWd1RDNGpl/ztBxPU/93fyEzb1CW+hAI9zQ0uWiPex1dKuPjeJv7J8XFILu
         KOSRlrgkZcw4zNEYwo2KMpUvdhTNn9RTrbXykOyR84q56xHjsTKejpGG08ObeQFo2mcB
         sDuyQjw1r59QqFKs91L8JVpNQOb5ic66nEfTxtMm/lPq9HrKeytOUJiV97bvU6MKkZEB
         9aXA==
X-Gm-Message-State: APuU4Z+IGAX4USffztXokpVVhcCbSozfmx7Aq5C0YusuK6kBNmHJNM08
	L7KrGfQztSm1vCNIBY4YIQwakxRFmAgncOLLzLaV+Dk20tG2+jsDJZa/JDjhGg==
X-Gm-Gg: AYBFou18MKW71KYHEqstAVryfZmEHqLZy0WPx0sbPK5nCqnHt8L+eh0c0p7vNhEFhxt
	6iINF34s9Ips6kOAYQDF4kTLzCv2wnvDfUFgUC2/ZkSUbTOJ6Dl2+mdx9riFKuEjdtiyg9AHnFJ
	5CWdTPZBNl41/tdufIFey7TSlmNaoPm5AHqrxwhight2Wo6zl1OqkWQjY5f7r+ihaVlUQcejIBr
	7YGYWRWTIsywbwG040WDOm2DTd2aTdzU382GE8glcOqOHT1Da69/GqK2NTjrShsTkVwonGPRuC2
	pGmnJPaNzlfixUkiYt21e7PTg4rMUo3jwMpNfvFJejPLHuTnRahwocHgcygDYp94tiJlr+MVVhv
	gHNU2NgzsJh6oQGNKa28dHixREMlZ0F8VDpJSbnYhC+CgUOddsNoaC5f1vUzsN8JNI76KXY6aoA
	c5/t3IoaCFNBB2wOVoxkGf7SALHFW2ATERKaGcj8QWsxFKgLqHritOVuK41hZ9kf6wnWOTrC0os
	f8YNsA3WwGBOGYLu9S88uGJT9qzotAVFnOywCFBSI3LswTox6OC5C7gnvwEXzjCuT2gbLWA5ArM
	xx5FtRLHVU77WI/9t09ScxGXZQDDAjP57h1CWbmU6yokK1X2k9Rwry5KbOHbfcBaB2T2BHFyeW1
	odSwpK1Y=
X-Received: by 2002:a17:90b:4c0c:b0:3a0:516d:9f87 with SMTP id 98e67ed59e1d1-3b1b0a1f01cmr4288419a91.13.1794612503105;
        Fri, 13 Nov 2026 15:28:23 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1bfb607e7sm1279789a91.3.2026.11.13.15.28.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 15:28:21 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/4] layerindex/utils.py: fix sanitise_html() for Python 3 and current bs4
Date: Fri, 13 Nov 2026 15:28:07 -0800
Message-ID: <20261113232808.96792-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113232808.96792-1-tim.orling@konsulko.com>
References: <20261113232808.96792-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 23:28:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5342
Content-Type: text/plain; charset="utf-8"

Site notices showed a literal b'...', because sanitise_html() returned
bytes, and a notice with an attribute on an allowed tag, such as
<p class="x">, failed to render, because current Beautiful Soup needs a
dict for tag.attrs. Return a str, clear attributes with a dict, and
move off the deprecated findAll() and renderContents(). Add tests.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/utils.py |  6 +++---
 tests/test_utils.py | 13 +++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/layerindex/utils.py b/layerindex/utils.py
index fd29de0..8e06463 100644
--- a/layerindex/utils.py
+++ b/layerindex/utils.py
@@ -544,13 +544,13 @@ def run_command_interruptible(cmd):
 
 def sanitise_html(html):
     soup = BeautifulSoup(html, "html.parser")
-    for tag in soup.findAll(True):
+    for tag in soup.find_all(True):
         if tag.name not in ['strong', 'em', 'b', 'i', 'p', 'ul', 'ol', 'li', 'br', 'p']:
             tag.hidden = True
         elif tag.attrs:
-            tag.attrs = []
+            tag.attrs = {}
 
-    return soup.renderContents()
+    return soup.decode_contents()
 
 def squashspaces(string):
     return re.sub(r"\s+", " ", string).strip()
diff --git a/tests/test_utils.py b/tests/test_utils.py
index 95b5e04..248b562 100644
--- a/tests/test_utils.py
+++ b/tests/test_utils.py
@@ -85,3 +85,16 @@ def test_in_nested_layer(repo_with_nested_layers, path, expected):
     assert utils.in_nested_layer(path, nested, repodir) is expected
     # Absolute paths give the same answer
     assert utils.in_nested_layer(os.path.join(repodir, path), nested, repodir) is expected
+
+
+@pytest.mark.parametrize('html, expected', [
+    # Allowed tags are kept, but lose their attributes
+    ('<p class="x" onclick="y">Hi <b>there</b></p>', '<p>Hi <b>there</b></p>'),
+    ('<ul><li>one</li></ul>', '<ul><li>one</li></ul>'),
+    # Other tags are dropped, but their text stays (escaped)
+    ('<a href="http://example.com">link</a>', 'link'),
+    ('<script>alert(1)</script>', 'alert(1)'),
+    ('<div><i>x</i> &lt;y&gt;</div>', '<i>x</i> &lt;y&gt;'),
+])
+def test_sanitise_html(html, expected):
+    assert utils.sanitise_html(html) == expected
-- 
2.56.0

