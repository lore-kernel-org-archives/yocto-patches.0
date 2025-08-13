Return-Path: <dixitparmar19@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70EACA0EC4
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 03:32:38 +0000 (UTC)
Subject: Re: [PATCH v5] [matchbox-panel-2] panel: added sysfs support
To: yocto-patches@lists.yoctoproject.org
From: "Dixit Parmar" <dixitparmar19@gmail.com>
X-Originating-Location: Pune, Maharashtra, IN (223.233.84.16)
X-Originating-Platform: Linux Chrome 129
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 12 Aug 2025 20:32:28 -0700
References: <83bc1d22-e6e3-41d7-b380-5d9387c9959e@gmail.com>
In-Reply-To: <83bc1d22-e6e3-41d7-b380-5d9387c9959e@gmail.com>
Message-ID: <23953.1755055948946532766@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="qrIhFIbzTGibnUjsIC9c"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Aug 2025 03:32:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1978

--qrIhFIbzTGibnUjsIC9c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 02:16 PM, Gyorgy Sarvari wrote:

>=20
> One more note, I'm sorry sorry for forgetting this from the previous mail=
.
>=20
>=20
> On 7/16/25 05:17, Dixit Parmar via lists.yoctoproject.org wrote:
>=20
>> +
>> +static gboolean read_val_from_file(const gchar *dev, const gchar *f,
>> gint64 *val)
>> +{
>> + gboolean ret =3D TRUE;
>> + gchar *endptr;
>> +
>=20
> The endptr variable is not used at all, I think it can be removed.
> According to the docs g_ascii_strtoll accepts NULL also instead of a
> pointer as the second argument.

Noted.

--qrIhFIbzTGibnUjsIC9c
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Mon, Aug 11, 2025 at 02:16 PM, Gyorgy Sarvari wrote:</div>
<div>
<blockquote>One more note, I'm sorry sorry for forgetting this from the pre=
vious mail.<br /><br />On 7/16/25 05:17, Dixit Parmar via lists.yoctoprojec=
t.org wrote:<br />
<blockquote>+<br />+static gboolean read_val_from_file(const gchar *dev, co=
nst gchar *f, gint64 *val)<br />+{<br />+ gboolean ret =3D TRUE;<br />+ gch=
ar *endptr;<br />+</blockquote>
The endptr variable is not used at all, I think it can be removed.<br />Acc=
ording to the docs g_ascii_strtoll accepts NULL also instead of a<br />poin=
ter as the second argument.</blockquote>
Noted.</div>

--qrIhFIbzTGibnUjsIC9c--

