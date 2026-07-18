Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B326C4451B
	for <webhook@archiver.kernel.org>; Sat, 18 Jul 2026 09:02:32 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2593.1784365338762255757
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 18 Jul 2026 02:02:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=PgEX0Hzb;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954d383e64so5715715e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 18 Jul 2026 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1784365337; x=1784970137; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWvbmkWxaPuscfw+lotR8NBdL8FsM9oW4psPSifOfa4=;
        b=PgEX0HzbEnVZFDEvXbD2yAKbK8fN5pzvtAIOC794xfzwFB3Z1+IW1NU3OwwG+xHSwK
         m7cDI17eMG9V201xse6Rg/weeZhmUaHa7qfDxc716XLnSREllk4D8Wjg7/Op8mRFLYQg
         UzsjkDBc525Gsd6rgr3jf9cyL8XhH0/rZdItU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784365337; x=1784970137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jWvbmkWxaPuscfw+lotR8NBdL8FsM9oW4psPSifOfa4=;
        b=XHuguteisk6pb12QHaY34cbB8wKRSE4wZvll82QdC+wIeqbGZ4Lbb4vnvjym3aeYpV
         41mJUGaWckVp8GVxbTVTSs/5jO/q7qyjf2rFi4UgZBQVTXgm3Qp5ckyTIAOVy/pObEwJ
         VBkUC1vXycOQe9onntp25qu4ZgpNbFe8BKHEQR5VZQTQ9R5K1lWdpuXGnfwqpTtyCza5
         wNxnCmrY1pFZnm0POaLCnutWLcCPT0i0UcAweXM/l9vL8ddPOQH9FXCQEfGuxhOxy1R6
         ifU6l3HjJ8HWoSR6WXL7JMeY0g2shazi93IGz3hxvPBy5Y1/u3Nl2FHDCxloDg9NXNXH
         E3uA==
X-Gm-Message-State: AOJu0YxQ0s6Tb1+sDLjUfYOqvqAhcLEfbwmMgWs2PuEqME8V201CAnuH
	gkJcZ725icFpLeGuwXef5NNfYl88u9DeSawD5o3LA2T07SqOb0BOwZKgl6S/eJFCAU3CtZVTY3u
	g4y0VMrI=
X-Gm-Gg: AfdE7cnSUCB/j9+nu2vsl4glLtwxmxAO+FoqNCh/dfDU5XwFbGAg2L62gxfXu9bTlPs
	ontQg+DLmpptj0GIe/DCXsDskAQccB8unbTkWSRB5vPACIbKFDMRtZ8ASEN/G8PfKpVXr4+//1X
	6RvS7yM3Okja6C+mwaLbiAOqqtDwRknD6jOIPvDZBsLC7cup+Mj0oOeMNghn9SYBS9DxqpdjAyl
	+dAU6rkzAPhh1Xl3R+9pHNh1YSzk8f5PlTbOHOUhWzNHp22RAe/JTLTl+D4bPx746C5UIH6jShF
	CnKBKRnuXf69RZK2JrmzTuueB4GY/TBRTCDP6+sWcuze0O/wvc91wHMH3F+HDth3bLHpo5AWjO3
	Pt6b4mn5qnlsFaijGHINMhoRNDmRIWWv14ne6tisaojK9MMhWqwF+r/Y2lw/h50gsvUQbtOP7HJ
	oQRZxW5RzggeXq+2KZx1zV3qmKzJECiuLG6FQC8PEgyU21eqWcxpYyi2C2AYF4Aq5RtTSdhAczw
	Zn4Cqo=
X-Received: by 2002:a05:600c:2156:b0:493:f822:ac5e with SMTP id 5b1f17b1804b1-4954a411570mr53739145e9.23.1784365336744;
        Sat, 18 Jul 2026 02:02:16 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa001444456ef7d84e9a.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:1444:456e:f7d8:4e9a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495499a5847sm82201445e9.2.2026.07.18.02.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 02:02:16 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH] summarize_top_output: skip blank lines in top output
Date: Sat, 18 Jul 2026 11:02:00 +0200
Message-ID: <20260718090159.3460055-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 18 Jul 2026 09:02:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4511

From: Yoann Congal <yoann.congal@smile.fr>

Blank line can happen in top output. e.g. in [0] at the end of the
block.

Skip those to avoid this error:
| Traceback (most recent call last):
|   File "/srv/pokybuild/yocto-worker/qemux86-64-ptest/yocto-autobuilder-helper/scripts/summarize_top_output.py", line 181, in <module>
|     main()
|     ~~~~^^
|   File "/srv/pokybuild/yocto-worker/qemux86-64-ptest/yocto-autobuilder-helper/scripts/summarize_top_output.py", line 178, in main
|     short_summary, summary, kernel_summary, zombie_summary, other_build = summarize_top(outputs, target)
|                                                                           ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^
|   File "/srv/pokybuild/yocto-worker/qemux86-64-ptest/yocto-autobuilder-helper/scripts/summarize_top_output.py", line 66, in summarize_top
|     cmd = line.split(maxsplit=max_cols)[-1]
|           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^
| IndexError: list index out of range
| ERROR: Command ['/srv/pokybuild/yocto-worker/qemux86-64-ptest/yocto-autobuilder-helper/scripts/summarize_top_output.py', '/srv/autobuilder/valkyrie.yocto.io/pub/non-release/20260717-146/testresults', 'qemux86-64-ptest'] failed

[0]: https://valkyrie.yocto.io/pub/non-release/20260717-146/testresults/qemux86-64-ptest/intermittent_failure_host_data/host_stats_do_package_write_deb_failure_1.txt

This should fix [YOCTO #16338].

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/summarize_top_output.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/summarize_top_output.py b/scripts/summarize_top_output.py
index 618cde1..dfd4299 100755
--- a/scripts/summarize_top_output.py
+++ b/scripts/summarize_top_output.py
@@ -63,6 +63,8 @@ def summarize_top(top_outs, target):
         zombie_summary = {}
         short_summary = top_out[:top_header + cpu_hoggers]
         for line in top_out[top_header:]:
+            if not line:            # trailing blank line before "end: top output"
+                continue
             cmd = line.split(maxsplit=max_cols)[-1]
             if cmd.startswith(HOME):
                 b = cmd.split(HOME)[1].split("/")[0]

