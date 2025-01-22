Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F033C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 08:10:29 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.38518.1737533422920244706
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Jan 2025 00:10:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=kPMeXUE+;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D003C0008;
	Wed, 22 Jan 2025 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737533421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzgoiqDxvls/0eJynYeJv4C+269G0rnom6zpPNK/AxQ=;
	b=kPMeXUE+5wAQKEUSqqJHtMvwi6+0gOZX2NQ223TUh46VB54WmglPruhF1e67yroDRpQ/0N
	u5U0J8gNc0SCv10euSOtikHykZkz7/+fcYoNj7luOVQC7oQ4P9zkjtS6UF7go/mitzEipZ
	KTGUjXARNi2Bqggi7rKe1bkn3stQiyBmMsGkXJOJrpZpK9dPgTPy5TkO3XQvfXrdvjZB+G
	PaSDmjqUnDrMWfstQPO1BWDB3bo063dokFXLZimXYTkW1qf4ORp4J4mPBCQioQYaPWB56b
	FZlfji63jPNGOzk9bZ8rCiZPrFC9GlBVdcsCsUFe2e6MRR9956vUjwLrwjn1EA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jan 2025 09:10:19 +0100
Message-Id: <D78G6XLG1PEU.I9ZF3M0NFRU2@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <yocto-patches@lists.yoctoproject.org>, "Enrico Scholz"
 <enrico.scholz@sigma-chemnitz.de>, "Scott Murray"
 <scott.murray@konsulko.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH]
 classes: rename to classes-recipes/
Cc: <openembedded-core@lists.openembedded.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
X-Mailer: aerc 0.18.2-100-gc2048ef30452-dirty
References: <20250120165117.737681-1-enrico.scholz@sigma-chemnitz.de>
 <1f6cdeb4-c868-e32c-4372-123371eb4b12@konsulko.com>
 <lybjw1ffw0.fsf@ensc-pc.intern.sigma-chemnitz.de>
 <a5630788-8f4a-faa2-7d6b-8dc87dd1642c@konsulko.com>
 <648e69b6898d3f95bea785d1ee56e2ce500ae579.camel@linuxfoundation.org>
In-Reply-To: <648e69b6898d3f95bea785d1ee56e2ce500ae579.camel@linuxfoundation.org>
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Jan 2025 08:10:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1001

Hi all,

On Mon Jan 20, 2025 at 11:54 PM CET, Richard Purdie wrote:
> On Mon, 2025-01-20 at 16:32 -0500, Scott Murray via lists.yoctoproject.or=
g wrote:
>> On Mon, 20 Jan 2025, Enrico Scholz wrote:
>>=20
>> > Scott Murray <scott.murray@konsulko.com> writes:
>> >=20
>> > > > bitbake looks first in 'classes-recipes/' and then in
>> > > > 'classes/'.
>> > > > Hence, content had no effect and was just ignored.
>> > > >=20
>> > > > Rename folder so that it overrides the OE-core classes.
>> > > >=20
>> > > > Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
>> > > [snip]
>> > >=20
>> > > I'm pretty sure this is incorrect.
>> >=20
>> > Logic is in [1]
>> >=20
>> > --> first iterate (using $BBPATH) in 'recipes-%', then in 'recipes'
>>=20
>> Hmm, the code I looked at was in lib/bblayers/query.py, and its logic is
>> different AFAICT.=C2=A0 Can you confirm that "bitbake-layers show-overla=
yed"
>> shows it as being overlayed for you as it does for me?=C2=A0 That it doe=
s
>> would seem to indicate a bblayers bug, and there is perhaps some missing
>> documentation of this behavior (change) (e.g. I don't see any mention of
>> classes-global vs classes-recipe vs classes and how their prioritization
>> works wrt layers in the docs).=C2=A0 I'm CC'ing oe-core just in case I'm
>> really missing something here...
>
> I think bblayers needs fixing and we need to sort the docs too...
>
> Copying Antonin as we probably want a bug to track that.

I've created a bug to track this:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15724

Scott, I've assigned you to it, as you proposed to add this yesterday on th=
e
tech meeting. Let me know if you need any help for adding documentation (it
should be part of bitbake/doc most likely).

Also let me know if I got it wrong yesterday and if I should re-assign this=
.

Thank you,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

