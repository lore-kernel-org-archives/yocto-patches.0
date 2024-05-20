Return-Path: <anton.antonov@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB88C04FFE
	for <webhook@archiver.kernel.org>; Mon, 20 May 2024 08:08:44 +0000 (UTC)
Subject: Re: [meta-parsec][master,scarthgap][PATCH] meta-parsec: Update parsec-service to 1.4.1
To: yocto-patches@lists.yoctoproject.org
From: "Anton Antonov" <anton.antonov@arm.com>
X-Originating-Location: Bermondsey, England, GB (84.67.123.254)
X-Originating-Platform: Mac Firefox 126
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 20 May 2024 01:08:38 -0700
References: <d25d4de6-fc25-4519-9714-fce702453140@gmail.com>
In-Reply-To: <d25d4de6-fc25-4519-9714-fce702453140@gmail.com>
Message-ID: <17234.1716192518717451612@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="pKTvhGON9anN2gGYNTWn"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 May 2024 08:08:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/162

--pKTvhGON9anN2gGYNTWn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 12:25 PM, Armin Kuster wrote:

>=20
> On 5/16/24 4:42 AM, Gowtham Suresh Kumar via lists.yoctoproject.org wrote=
:
>=20
>=20
>> Signed-off-by: Gowtham Suresh Kumar <gowtham.sureshkumar@arm.com>
>> ---
>> .../parsec-service/parsec-service-crates.inc | 78 +++++++++++--------
>> ...rvice_1.3.0.bb =3D> parsec-service_1.4.1.bb} | 2 +-
>> 2 files changed, 47 insertions(+), 33 deletions(-)
>> rename meta-parsec/recipes-parsec/parsec-service/{parsec-service_1.3.0.b=
b
>> =3D> parsec-service_1.4.1.bb} (97%)
>=20
> I can take this for Master but am having an issue see justification for
> scarthgap.
>=20
> Why should I take this for scarthgap?

Scarthgap release of meta-arm included a new version of Trusted Services at=
 the last moment. This new TS version is not compatible with Parsec and bre=
aks building Parsec with TS provider in Scarthgap. Parsec v1.4.1 includes a=
 fix for the issue.

Cheers,

Anton

--pKTvhGON9anN2gGYNTWn
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 12:25 PM, Armin Kuster wrote:<br />
<blockquote>On 5/16/24 4:42 AM, Gowtham Suresh Kumar via lists.yoctoproject=
.org wrote:<br />
<blockquote>Signed-off-by: Gowtham Suresh Kumar &lt;gowtham.sureshkumar@arm=
.com&gt;<br />---<br />.../parsec-service/parsec-service-crates.inc | 78 ++=
+++++++++--------<br />...rvice_1.3.0.bb =3D&gt; parsec-service_1.4.1.bb} |=
 2 +-<br />2 files changed, 47 insertions(+), 33 deletions(-)<br />rename m=
eta-parsec/recipes-parsec/parsec-service/{parsec-service_1.3.0.bb =3D&gt; p=
arsec-service_1.4.1.bb} (97%)</blockquote>
I can take this for Master but am having an issue see justification for <br=
 />scarthgap.<br /><br />Why should I take this for scarthgap?</blockquote>
<p>&nbsp;Scarthgap release of meta-arm included a new version of Trusted Se=
rvices at the last moment. This new TS version is not compatible with Parse=
c and breaks building Parsec with TS provider in Scarthgap. Parsec v1.4.1 i=
ncludes a fix for the issue.<br /><br /></p>
<p>Cheers,</p>
<p>Anton</p>

--pKTvhGON9anN2gGYNTWn--

