Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3831.1794620331205747875
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 17:38:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=heaiKnOf;
 spf=pass (domain: gmail.com, ip: 209.85.215.180, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso1789283a12.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 17:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794620330; x=1795225130; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TG21Ck4SL9l/yOW5PJgF4Z1rp79pT82lhsVKR8pKJ9w=;
        b=heaiKnOf20/82wPYiWIMerr24KL833Etm79fFBuyLTbkwuAtzySgj5mRjfHJC1Aigy
         bGNpmUOwBtRjq0JyFccFYYZb6PHEcIubJgTPw+z24TToZmcyGZJcXlmH9Q8b2FxCIt+B
         rMS0GVlpX2OVKjnfKaJ7RqvFMiN/K3L4+vxUcbnzqijlKWYevH7fNVkrXAraUhdUYPuN
         bxLKrHjsSTRDCcZva/RhDVjHB7rO+xGPoZoknirwRgfwRVhWB6Dr2/g6Oz31+vmmYtOj
         iI4KQpb3twzS7MeheZYCQXxwp+5iOJr/FeUDrUW/uz5H8GgE5Efn+wfHP7YZwVdjspj7
         0w/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794620330; x=1795225130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TG21Ck4SL9l/yOW5PJgF4Z1rp79pT82lhsVKR8pKJ9w=;
        b=mP9M26kv+09aaOitpvQq/rIBUA/ytOf3AJpim0A+CNPi5PHsSxZsLDdX6fnVHr/QZj
         35a51CCsa4d5P59+gi/xFwzwaL5d/tz213ZsCur9NZlMGrUhd9UqOFpcTDu38TYK/f8D
         qxI8YOE6/rMMMkrCYPl5CM91poCNwjG2F5ndC4ckncnZXQzup7dS6GjacdxjQdL6YP1I
         K/EQY36QEWX76pJzittuPXBU5jzM/kzPUCeZkZtwWYf70qWW2sAREdOJ8o937zh1CMaU
         tLgOgIXmUkN6jInIoFWK35yR+NRYwo6ovat2O678nAzPhRoL2kYQNCup5TjQn1wisFA0
         owgg==
X-Gm-Message-State: APuU4Z9kwx3WJu7F39pc2a/ohAkBoRZBg9iN645Onb/V61UvgbeqpEJo
	d+UldtWfQIPdN9VyjybbfpKyYHjMF97EpR3mT2c0FiyGcqnEmDjI6+QpIt6bCA==
X-Gm-Gg: AYBFou2IKdG8HeOhHv/X98WbdOYVHPd0ANpJio8UEgFVRP3PwMB+o4d/U8GDdOUb3SD
	Pa3bHn6O9qJP4OsbB/d/GPnuIjl9302eDNNm6932wxVNxbMTXdlfwbpuYl0VtId7+nWP4/J5aWG
	iw54sIIJyZHd+6r4qXHVwOfi6p+jYM8KA19P3X+ni1gHl0InpwIh6DIwXjPbUR9YvRskPgQoCFs
	94kgoDRb6Sto0Ld9mI56fW3k7Vim/tCUCfj5zxJXOfLBHsNBR0T5xndw8YFZEEfr9Y+iTnMKR6O
	0eF3GPovCi5wouwyOW37Q3wsa1rDfteARnezjuxmTYNo1dVfMfSRRGipHKrwHKnkpWi57K1RNgI
	l7me/AzMu+jU0jAgQXzWV9ZiFtKp+CKbHunInFTbBUqVnU6JxNe5e1gDQ9ncWRKRWYQswQ8wZGc
	0YKAna4DV9+JdJhSkRK3ydZUUCz+c7W0jgoR3XWS2j2MqUluPW9wFWtDxUc1kL3fXuCZ6QUf0hB
	W6r9surKCWtDbgd2RTTi/+58A+BtGGmKnoxFgSQLCdJh13ieRNmsnSkPy6YEu6yVyxqaYKvTRiH
	a7cbr7Tehq4MwDmrly3VepfE726iWL4TXCJ/xgA3sLE6JNTxdCHLxqMThxqJGQ==
X-Received: by 2002:a17:90b:5687:b0:3ac:bc3d:6fe5 with SMTP id 98e67ed59e1d1-3b1b089e26fmr4416017a91.7.1794620330389;
        Fri, 13 Nov 2026 17:38:50 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb18b73sm6593679a91.3.2026.11.13.17.38.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 17:38:48 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/2] layerindex/utils.py: fix the error message for a bad dependency version
Date: Fri, 13 Nov 2026 17:38:39 -0800
Message-ID: <20261114013839.51312-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114013839.51312-1-tim.orling@konsulko.com>
References: <20261114013839.51312-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 01:38:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5355
Content-Type: text/plain; charset="utf-8"

The message logged when a dependency's version can't be compared used
"dep. layer_name", raising AttributeError instead of logging the error.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/layerindex/utils.py b/layerindex/utils.py
index 3889468..d8efc68 100644
--- a/layerindex/utils.py
+++ b/layerindex/utils.py
@@ -182,7 +182,7 @@ def _add_dependency(var, name, layerbranch, config_data, logger=None, required=T
             dep_layer = get_dependency_layer(dep, branch_name, ver_str, logger)
         except bb.utils.VersionStringException as vse:
             if logger:
-                logger.error('Error getting %s %s for %s:%s\n%s' %(name, dep. layer_name, branch_name, str(vse)))
+                logger.error('Error getting %s %s for %s:%s\n%s' % (name, dep, layer_name, branch_name, str(vse)))
             continue
 
         # No layer found.
-- 
2.56.0

