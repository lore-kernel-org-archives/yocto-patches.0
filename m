Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.885.1793726871850267609
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Nov 2026 09:27:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@codethink.co.uk header.s=imap4-20230908 header.b=A0Nk2eIF;
 spf=pass (domain: codethink.co.uk, ip: 188.40.203.114, mailfrom: marcel.ziswiler@codethink.co.uk)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:MIME-Version:
	Content-Transfer-Encoding:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To; bh=qXy8SKiEKpjqHCduGcqK+YsKpbXY1QYReBw8Nn6ztvM=; b=A0Nk2
	eIF2GrtlHzIWBKr0thehlTF4MK72Pu/TBnMH83OnGm7YWtjQ6qVucJQrwvSZn3WggrGIVUpZYroMy
	6sIm4nnUi2RU4y7b6jVwzFxhmdy1UBP+++CgUbbXIuZuJgsDOmhHabJ6aCVcpW0gt2NvED18jtc5T
	rTGlw8xNKP/W+2Lfz+cRnK+70+Xpgatg6OWmoaz15xvun92krL5iNlf2hnYnFHiHb62mqFb4MczQb
	7o7rzg0xGM1YxsalEccTqhLN6JJCkFarZ2YQM6olGF/zA+ip4dQa+s3KqcGGUpyz6VQSm+ivHG10b
	UgDdfUkWdOXgwR0s9EY09oOIn5lLQ==;
Received: from xcpe-84-227-225-151.dyn.res.sunrise.net ([84.227.225.151] helo=[10.10.1.182])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1xOIIU-009CCh-Uz; Tue, 03 Nov 2026 17:27:47 +0000
Message-ID: <c760fda716ec4f3cd24a93e7894a492fa917a9f3.camel@codethink.co.uk>
Subject: Re: [yocto-patches] [PATCH] tpm2-tools: Fix build
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: Yoann Congal <yoann.congal@smile.fr>, 
	yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <khem.raj@oss.qualcomm.com>, Scott Murray
	 <scott.murray@konsulko.com>
Date: Tue, 03 Nov 2026 18:27:46 +0100
In-Reply-To: <DMLOIWW3M0ST.2LJROJT68ACDJ@smile.fr>
References: <d3ed7d76f36436b8d5edd4b8b328205e809b63e9.1793706170.git.marcel.ziswiler@codethink.co.uk>
	 <DMLOIWW3M0ST.2LJROJT68ACDJ@smile.fr>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
MIME-Version: 1.0
Sender: marcel.ziswiler@codethink.co.uk
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 17:27:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5223

On Tue, 2026-11-03 at 16:26 +0100, Yoann Congal wrote:
> Hello,
>=20
> I think this lacks a [meta-security] in the subject line.

Yeah, indeed, thanks!

I resent it with that in place now : )

[snip]
