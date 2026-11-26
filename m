Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13878.1795700012155247693
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Nov 2026 05:33:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mailbox.org header.s=mail20150812 header.b=O7oUIJDn;
 spf=pass (domain: mailbox.org, ip: 80.241.56.161, mailfrom: patrick.vogelaar.dev@mailbox.org)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jZyDR4GrlzKmFq;
	Thu, 26 Nov 2026 14:33:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795700007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ffd557PTEO2IAwPXVJJZe7SyvWSRiqnxJOMV+vjz46w=;
	b=O7oUIJDnkcKU8pOyfe68FTCOtYz4lHLMuQSrFEDmEUdidIErw9cAVoO+Vo8AWvKxIBqqju
	tmSFR74BBa60cV7+H2ifRJDQTn9SL8wM9bulMSsa5CV5o37b8gQdCiy7cXwv+WEcJ/iCth
	INVsij3WGMuse01sF7xwWm+1lOafx3XNPH/EV83qFNNPL+g028Un/26cDI6RNTv7+OeSmj
	S+m5QbUwlkPZcgGv86G3mkxoHais4QuP06jP+UUrihCR2oLhgjrIYSMlp25CoqWKyJqDvL
	MS9vGfqL/gKu3WlvLkk2dZw1MMgWh65cmjVSaovaNlPbmAVNxaOm1NiNm2WE7w==
Date: Thu, 26 Nov 2026 14:33:27 +0100 (CET)
From: "Patrick Vogelaar" <patrick.vogelaar.dev@mailbox.org>
To: "yocto-patches@lists.yoctoproject.org"
 <yocto-patches@lists.yoctoproject.org>
Cc: "scott.murray@konsulko.com" <scott.murray@konsulko.com>
Message-ID: <917882156.181166.1795700007162@app.mailbox.org>
Subject: [meta-lts-mixins][scarthgap/rust] build problem with suricata
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.54.538
X-Originating-Client: open-xchange-appsuite
X-MBO-RS-META: akeaboa7tnqwdji7ej674fgn9ihkzuri
X-MBO-RS-ID: 9ff64c67c11fd3af3f5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Nov 2026 13:36:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5542

Hi all,

Commit 4c195f6dd000231e5c7797cf0d9202b6339f861d "classes/cargo: merge oe_cargo_build into cargo_do_compile" [0] causes the suricata build to fail because suricata on scarthgap uses oe_cargo_build [1] which was removed by this commit.

I would be happy to do the change but I am not sure what the process is within meta-lts-mixins. Would it be a revert then of this commit or something else?

[0] https://git.openembedded.org/openembedded-core/commit/?id=a64ac03a6146555f1847cdf43e3f86d14f6e506d
[1] https://git.yoctoproject.org/meta-security/tree/recipes-ids/suricata/suricata_7.0.13.bb?h=scarthgap#n99

Patrick
