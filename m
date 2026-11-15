Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7561.1794702937974810716
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 16:35:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=rnZ5SqAS;
 spf=pass (domain: gmail.com, ip: 209.85.216.43, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b37951a397so390300a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 16:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702937; x=1795307737; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YIqlGcwSf45jpSzyi+CQ610ZKHKNvwSKeiA19woEK+g=;
        b=rnZ5SqAS77WIRkhsxSWIb5nXy77SzznvULLfH0NjgvrKFsJBoryaeOlOGRNXa/fbkT
         BK9IgRbZuhOslI9vWW9cIJY9YoDMhZunFdu5LV+2gAL6yR4kfmqEOY1qf8JDfwQDlpHr
         S+SFQy623E44sg639Ay7C1HphtuVqTCU/n0pwuD/6mKKo3G56W/BugW0RQc8/Zdf8zOG
         YopW2OMzFQ2KJ/Xx0TioHOEcsOPaj+ulHamxE12a9F9IwIwu6DaufReGf6Gpj8efkwLC
         1yGuP1tnFz6I8Or6hSeu02cB2sGRi5w2mHjvvZb2qpnzL5RPTWjzvEVFWb0t3Y2QbHfd
         8+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702937; x=1795307737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YIqlGcwSf45jpSzyi+CQ610ZKHKNvwSKeiA19woEK+g=;
        b=s6jHRNToIBGjmhpRHl3ncCFJrsgClolgHzHgzj8WRzIt45xLl+7HDaD+/a4BtTeuD+
         Vggveu663zZW9EVo37Y2rY/83PQfdhHOOiWPcrJOAK5beu1ZWDo44epx9K1uQxRZqrQc
         ECpNiDdXG7m9xMgNC2SB94G1T+WMMTw6pjPnWy4M8DAUAVdEFJ5DPF29WqGhdEu0gagY
         kmXHUaeVSs2ZAf+utQ20LDfvyg9I9rPKZAILMEwGAKfLnJWGHZs3AsbpoF+e5LOam/sr
         lVpaDHOmt91FUVZ9UZtEqArR6Va+DsBJYwcBrKDPkgiOJ272C/x30AoNB1nUzJxLXLIF
         Ba0w==
X-Gm-Message-State: APuU4Z//WIPF+iVK400LBpnxncLuBWFaYXKNIEglECfGGxIYZ6DkqCxb
	YQYR1DtlvtnTrIGZWItdu+NU6P0cY5qCZCqjgBsYyTLDzo5o33CNpLrAFIz9sA==
X-Gm-Gg: AYBFou0/nF65fU3b/Gc9aYJNrhdnI14OX84P8aHPyyBnwPZA8WhdJ66qUvSbgDepnAz
	TRTfFU4E/Eq9av8HLN7rttAkv5w51VyQ8Qm/HFrQR+x2qBn1xQdUF6M4BFxv5A/QzJuddjKOtbq
	r/sfn4ZKwwsulxkR9aGxY95BrsT8wt/kxEHPcnfSpPmsNa2eHnhFtgIiK9kKEc0FEYRQCXZBYH/
	W7UaaaxzxXIcRZ1PR591zubD2t0LsTl97fCMTZQiGBTvawtT0lAZftwIjLUy1zbORkmk+WauDb9
	Qtp7fzYSJ7uj4GEt31QohSiwlzhWPJ3z/jBl+YF4e27P0Sh3LD0m7rG4KYIuKjrHxnkPOXUDuSo
	EA/DjsTn4UQ8hXtB1F5TIIPg6xr/lnlxLETRKxNx1J9MCs3R2ZyD8N62kWo4OtPsQiFJzEeRi5/
	JTrPUdUMhVTnhGgRApACvqDhMWiSE7FR1swfulm/oZwLhURcaTFmrxfoxyfUb0EUXEWMvMrE/HS
	2sy+n+jObhR/uE/ncu7KZvnC3OPUkfnwG5//ZZ5HERoKssobtiHONsnO8+6kPWQY4wnJVqofOyX
	prhJntuYYeib5HHri+ntFTfe2lsJFEtXRqM0UnlIr5m/7AIueZqWr0z3NihtViF0lXuWkDhrA65
	WMm525MQ=
X-Received: by 2002:a17:90b:4f86:b0:3b0:9b3c:4434 with SMTP id 98e67ed59e1d1-3b1b0ca50f0mr6490649a91.36.1794702937229;
        Sat, 14 Nov 2026 16:35:37 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b39fb9a3sm5464089a91.3.2026.11.14.16.35.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 16:35:35 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 5/6] conf/local.conf: use OEBasicHash for parsing
Date: Sat, 14 Nov 2026 16:35:05 -0800
Message-ID: <20261115003506.53654-6-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115003506.53654-1-tim.orling@konsulko.com>
References: <20261115003506.53654-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 00:35:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5383
Content-Type: text/plain; charset="utf-8"

OE-Core 5596ea156d made OEEquivHash the default but BB_HASHSERVE was
only set in the following commit, so parsing 3c00ad5d3b fails with
"OEEquivHash requires BB_HASHSERVE to be set" and the BitBake of the
time hangs instead of exiting, stalling rrs_upgrade_history.py.
Parsing doesn't need hash equivalence, so select OEBasicHash; this
also avoids starting a hashserv for every parse on current master.

[YOCTO #16504]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 conf/local.conf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/conf/local.conf b/conf/local.conf
index 82cc577..5ce9ade 100644
--- a/conf/local.conf
+++ b/conf/local.conf
@@ -18,6 +18,10 @@ HOSTTOOLS_NONFATAL := "${@d.getVar('HOSTTOOLS', True) or ''} ${@d.getVar('HOSTTO
 # oe.utils.get_gcc_version() in a python expression
 HOSTTOOLS = "gcc"
 
+# Parsing doesn't need hash equivalence; OEEquivHash would also need
+# BB_HASHSERVE, which some OE-Core revisions don't set
+BB_SIGNATURE_HANDLER = "OEBasicHash"
+
 # Recipe reporting system configuration
 #require conf/distro/include/maintainers.inc
 #require conf/distro/include/distro_alias.inc
-- 
2.56.1

