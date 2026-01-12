Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87080CF45D5
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 22:12:37 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45276.1768255948676804869
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 12 Jan 2026 14:12:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EmlpjoJO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so38018135e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 14:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768255946; x=1768860746; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QyzBblMJc8iLqJmsm9azTT2gvQPstXtHjiLy1ZJ5bKo=;
        b=EmlpjoJOA+Y/M2ZB6x8HQD8qjUqUHHPq2JAns3xcsarL07Gddu2RbwQdkq/3QoVklk
         KW0UcsbV/QfIQ/s1CJTjohiDL3SVLISKw8Gs43Jt6F5ZbKWQ/zFu+i5iN169D8FNp+75
         m0uZHEWQN4dc4acPtyQ8e4GW0+UmCdYbcNx5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768255946; x=1768860746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyzBblMJc8iLqJmsm9azTT2gvQPstXtHjiLy1ZJ5bKo=;
        b=KNuLQJUEcs60yuQQ1ovvetOEJA2+K/6SDvNcPriCshOCYHD5ildthvGcMub3pM08P7
         uNILA9tXk2SydDIqj0VnT2ggLPL818A55Tk6kBZ7CsB6bSbW0Iyrl3VpSCsRLfrhXaTP
         O7Qd+K+1nmmLRQw08kMKJD7P2/Ndkz5VCDp32oiL8k5DsTpN47aB1VlGevqEJFiU5Liv
         Fed7AUxnyajNyXzaxsUE7SAj+kzURVAqeAQUmYorv0vVgBkjUYgGkd5FqqxGsm955WS9
         maLe24sU+EdVBTn7IF28TMkzZ5/mAlyxkKFhoZYHT+SCnfXAto9PbxaZ8U7RJyO6QJNf
         Kqsg==
X-Gm-Message-State: AOJu0YyPX9duoDqh7aYuSbRlPBToTxyRLRM1uFlErzaAwNab/dHzHB5Y
	BRcvtH18fpBkH8XXnvnAW4OhPop1oW4heqGWKnaTkgMPMPoH3maszZjP6SuvmXlP/kkEi6AQcYB
	dwDN2g30=
X-Gm-Gg: AY/fxX4MVDHfZekKViYOStcZ9kVZnsMdnm/8ViXoKtO1wtSmDEiBWv2iagDsl77k75+
	m5lGBjpC0vMWZdyfJcvCLYtxktmGxCl9tjqpDAtQWFCxRxP6NL4gMQYY6j1MQKz/8LarHawthjY
	DS6pGAWiZ0Fmh1/dR+/2aDuU60uqhHjNN2Yv6y19GYcx0G/o9RH4/DEcLe7G8pb5uGZAP2RmnAa
	WAKQQj2DPltRB7ARmDxIm44a+o36yt5fCx52/XyF1SG0CFLJMHJ9QXTxR8OnXoTd3tfpLuuVXnU
	rVO/bIpAYUo4JgmZA8Bd36PzM0QrosaTrCMXmhi8oBl5e0osx0wnSvufJg+Jwsm3fKLLVwqieCN
	vX+q24KWS8tXh0RtspnfE2FNTqxnPnBWXk+O8/WdKPXXwij9pLGLnxaWga6/nZqnTAnGuTwhtLY
	T244Ca3Vfndlnt7OMX0+kD1d/5Qp0fYaZNJk6xvA==
X-Google-Smtp-Source: AGHT+IEqwEkyAdvrnp4UBzYE5RdkoS5fYH0iKlflP6x0AatVoW86T4fGjXo2VfKDwM/8UGt6ZqxHKg==
X-Received: by 2002:a05:600c:1392:b0:477:9cdb:e336 with SMTP id 5b1f17b1804b1-47d84b369cfmr231114665e9.21.1768255946354;
        Mon, 12 Jan 2026 14:12:26 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a72e:a42f:ffd8:96a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ed9eb6fbesm811745e9.4.2026.01.12.14.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:12:25 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH] ports/linux/pseudo_wrappers: Avoid openat2 usage via syscall
Date: Mon, 12 Jan 2026 22:12:24 +0000
Message-ID: <20260112221224.774302-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 22:12:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2947

There is a CVE patch (CVE-2025-45582) to tar 1.34 in Centos Stream which
uses syscall to access openat2() and breaks builds if we don't redirect using
a NOSYS error code.

As per the other entries here, there is also concern about trying
to parse syscall arguments in this function too.

We still need to add a wrapper for openat2 itself which is in the new
upcoming glibc release.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ports/linux/pseudo_wrappers.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index c39cf20..6b54083 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -92,6 +92,19 @@ syscall(long number, ...) {
 	}
 #endif
 
+#ifdef SYS_openat2
+	/* concerns exist about trying to parse arguments because syscall(2)
+	 * specifies strange ABI behaviors. If we can get better clarity on
+	 * that, it could make sense to redirect to wrap_openat2().
+	 * There is a CVE patch (CVE-2025-45582) to tar 1.34 in Centos Stream which
+	 * uses syscall to access openat2() and breaks builds if we don't redirect.
+	 */
+	if (number == SYS_openat2) {
+		errno = ENOSYS;
+		return -1;
+	}
+#endif
+
 	/* gcc magic to attempt to just pass these args to syscall. we have to
 	 * guess about the number of args; the docs discuss calling conventions
 	 * up to 7, so let's try that?

