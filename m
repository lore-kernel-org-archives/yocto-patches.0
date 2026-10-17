Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E09ACCF2C4
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 18:32:23 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1922.1792261935521447634
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 11:32:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=LzUoNI5J;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so482106a91.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792261935; x=1792866735; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VT/XBt06NciPgTm60d8wSqtaBYnASyEBqnho5E0WhkQ=;
        b=LzUoNI5JqfjBw0elvrNqVIeHrEtVyfQuen/6vAbA+b1Nc4/IcM3TYMeHLqp7bXy/GI
         ZYBWu83FeZyzUMJiNmhK+NK3Cn70MuwoX0PbYlXYOYmCLlvwStfseIUEW+i7JVMqz9tu
         mKYywLTpNp8DcUaiOizqxa+RTsjgAY554M7dBbe2cxH5F4PnHw5OOjCaEoC7kran6by2
         JWC8PMxhN5yDsD+aS2BO4Ld+50SLeTDcru1fF+mb7xaGb3z7HKDxLFUdij3YuOjUEB8g
         XcxdW0Bp1Vx9SBgJxwijby/uH5VY4KNUfVzecb3K+NL78kno4/dyrVA4TWqQvSIZ46QC
         RQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792261935; x=1792866735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VT/XBt06NciPgTm60d8wSqtaBYnASyEBqnho5E0WhkQ=;
        b=xC5qj2+sjz/4axUl8pbkPL+DRNQ691WjFTHyod+80h6yT00HhdtibCZDalTV3ckr6k
         Wub/n0sxpwRBxsivjEfcG5LqWIN+3VsdVRl9cOmyDxBXi7GsQvU44CeO8BKn5vixGNK8
         eC6hjIPs5HnTrujKu5DgMJiWIM/swuWsxCzO8amT21byvTChduEt0LXqX/pbMkGzfs5O
         nCPtNW1g8SF7dv6feZXkeJ6cLsrIeG3NNFXbQETGhFm+JMVNecjof19lck04n0lMczI+
         JsUMthW9TkiieWVtWAc6tCYEHTNrL+DtIDwkikU2nqi76UMhs+ellf5OPxzN6Vgq1YBA
         xw7w==
X-Gm-Message-State: AFq9FYK5OdJQhYNkmwITRsGQN/8VAj87G0c0A+XTEUoy6EYDHARZvulz
	QXTjVRAmjTMJrXnnioYjWnAaXk9BsPsN9h6PKS15ExtwOqkt2A1TdTDTWPznuA==
X-Gm-Gg: AYBFou3Xv/9aUxzeYHf7jRnOCX8Wf4NG/oN2Pe5LliuQhelXIiqMuOO559xz46j/3vY
	c/WxdPD7na6iszrotFLFNWmzI6Dpse2F0M793uJ3OElhtE53txn6x+fYACEq7qjoQJqKSG5kqli
	BWYiDa94j6D7NMPhNIVlc+BXtYZMKirlUpShC1F45bX54Kcy5npSJc5OYWyayN00b0TcXUwZNMo
	0C0z3JM2jYBiH74gaZ+mrQi6w2rCz60QUwDYyJMGo7zupb8xluwnKa59pJOXwmYrBoe7WBqaZl3
	Ns7oeyRqV+KZPEOwkmDABMVyvt/43hLw/UmY3R20BPznLLdgQJZc489RkcpyZAevCov7qyr9+tc
	9rB5ATOjt/PDnYjnlX6vmTd07c8PLzF/0cbYjLKWbzJKPcvq+p3H/ZnP+70LAZycC6/liUwxCk6
	Sy7qcmF6GP8criMOkHQV6/MnVFYnOcBCdb/X3Yg0FJClniCwCWq84NgNFKl0kqV729X/WLfePWV
	9f1hK7CHH9c237GYGoHXpwDdxEK6QUUXRVebK46SA==
X-Received: by 2002:a17:90b:380f:b0:3ac:a1c7:20fd with SMTP id 98e67ed59e1d1-3acee97ae24mr3038226a91.4.1792261934833;
        Sat, 17 Oct 2026 11:32:14 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ace34c8d9asm5634097a91.5.2026.10.17.11.32.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 11:32:14 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/3] layerindex: use raw strings for regular expressions
Date: Sat, 17 Oct 2026 11:32:07 -0700
Message-ID: <20261017183209.90930-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:32:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5040

Fix the "invalid escape sequence" DeprecationWarnings reported by the
test suite in models.py, utils.py and forms.py. Python 3.12 turns these
into SyntaxWarnings and a future release will make them errors. The
patterns themselves are unchanged.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/forms.py  | 2 +-
 layerindex/models.py | 2 +-
 layerindex/utils.py  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/layerindex/forms.py b/layerindex/forms.py
index b0ffc31..733adc2 100644
--- a/layerindex/forms.py
+++ b/layerindex/forms.py
@@ -136,7 +136,7 @@ class EditLayerForm(StyledModelForm):
     def clean_summary(self):
         # Compress whitespace and use only spaces
         summary = self.cleaned_data['summary'].strip()
-        summary = re.sub('\s+', ' ', summary)
+        summary = re.sub(r'\s+', ' ', summary)
         return summary
 
     def clean_layer_type(self):
diff --git a/layerindex/models.py b/layerindex/models.py
index 1a2ec60..a72a72b 100644
--- a/layerindex/models.py
+++ b/layerindex/models.py
@@ -278,7 +278,7 @@ class LayerBranch(models.Model):
             url = base_url.replace('%branch%', branchname)
             if path:
                 splitpath = path.split('/')
-                for match in re.findall('(%pathelement\[([0-9]*)(:[0-9]*)?\]%)', url):
+                for match in re.findall(r'(%pathelement\[([0-9]*)(:[0-9]*)?\]%)', url):
                     if match[1] == '':
                         start = None
                     else:
diff --git a/layerindex/utils.py b/layerindex/utils.py
index 6c0ad8f..7e7ebe4 100644
--- a/layerindex/utils.py
+++ b/layerindex/utils.py
@@ -528,7 +528,7 @@ def sanitise_html(html):
     return soup.renderContents()
 
 def squashspaces(string):
-    return re.sub("\s+", " ", string).strip()
+    return re.sub(r"\s+", " ", string).strip()
 
 def sha256_file(ifn):
     import hashlib
-- 
2.56.0


