Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14113.1795700838239866905
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Nov 2026 05:47:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mailbox.org header.s=mail20150812 header.b=wqQ/s9eG;
 spf=pass (domain: mailbox.org, ip: 80.241.56.171, mailfrom: patrick.vogelaar.dev@mailbox.org)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jZyXL0DdKzMlq2;
	Thu, 26 Nov 2026 14:47:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795700834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8UzoicoLpfWf+qz0GolL/DCXwvMDuw1ba0CqljGyoQ=;
	b=wqQ/s9eGVRqo0VS5KIX3giOHAK7BYkDwHd/rwT7TijpFeYopwcXd+5GmE6ZldUUYwXBgL7
	2+nYoCpR+vTa3nxN4AFhvMw/Ha6Ne8fv9pyR/3QL7rJ7LNiAb0D4vKyc5LxH6+TXxuM4LT
	afDE+gY4ZWabu0pcgmPPbngQpToZaD4pU6BEI3kEgk3cAfQuLtgLtPm7va2sldfoqvohst
	kup0zgIQUW7EDlX+/pHOSxPM3lOBWSdNY5CfbEjL8kW5UVTaz2vemxnKaTpS+Yz1zpNO6N
	NVrrD9L+TwZJlENbcbAaHA48TUyp8LX0F5IdkuPlCIlJv+9noFFmCnUqEji4Dg==
Date: Thu, 26 Nov 2026 14:47:13 +0100 (CET)
From: patrick.vogelaar.dev@mailbox.org
To: "yocto-patches@lists.yoctoproject.org"
 <yocto-patches@lists.yoctoproject.org>
Cc: "scott.murray@konsulko.com" <scott.murray@konsulko.com>
Message-ID: <1501876072.182298.1795700833777@app.mailbox.org>
In-Reply-To: <917882156.181166.1795700007162@app.mailbox.org>
References: <917882156.181166.1795700007162@app.mailbox.org>
Subject: Re: [meta-lts-mixins][scarthgap/rust] build problem with suricata
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.54.538
X-Originating-Client: open-xchange-appsuite
X-MBO-RS-META: ydniu5e7ubbp54wjh9rwr4wjaxjam33q
X-MBO-RS-ID: e12317846a0fec3b740
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Nov 2026 13:47:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5543


Hi all,

Commit 4c195f6dd000231e5c7797cf0d9202b6339f861d "classes/cargo: merge oe_cargo_build into cargo_do_compile" [0] causes the suricata build to fail because suricata on scarthgap uses oe_cargo_build [1] which was removed by this commit.

I would be happy to do the change but I am not sure what the process is within meta-lts-mixins. Would it be a revert then of this commit or something else?

[0] https://git.openembedded.org/openembedded-core/commit/?id=a64ac03a6146555f1847cdf43e3f86d14f6e506d
[1] https://git.yoctoproject.org/meta-security/tree/recipes-ids/suricata/suricata_7.0.13.bb?h=scarthgap#n99

Patrick
