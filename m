Return-Path: <dixitparmar19@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E703BCA0EC4
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 03:29:49 +0000 (UTC)
Subject: Re: [PATCH v5] [matchbox-panel-2] panel: added sysfs support
To: yocto-patches@lists.yoctoproject.org
From: "Dixit Parmar" <dixitparmar19@gmail.com>
X-Originating-Location: Pune, Maharashtra, IN (223.233.84.16)
X-Originating-Platform: Linux Chrome 129
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 12 Aug 2025 20:29:41 -0700
References: <74c4ff06-6665-4da2-a328-aad36300a892@gmail.com>
In-Reply-To: <74c4ff06-6665-4da2-a328-aad36300a892@gmail.com>
Message-ID: <23953.1755055781231730733@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="8CNih5y03UqSoPh05ETi"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Aug 2025 03:29:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1976

--8CNih5y03UqSoPh05ETi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>=20
> I'm not very well versed in gtk, so if anyone tells me that it is
> idiomatic, I will believe it, but: why are these guchar? The code
> doesn't seem to do anything char-like with them, they are used as bools.
> Why not guint, or gboolean?

Ideally it should be gboolean, I dont recall why I kept it guchar. I will s=
hift to gboolean and see.

>=20
>=20
>> +static gboolean read_val_from_file(const gchar *dev, const gchar *f,
>> gint64 *val)
>> +{
>> + gboolean ret =3D TRUE;
>=20
> Should this be not FALSE by default? If the next "if" branch is false,
> it stays TRUE, even though it fails to read anything.

Its rare that we'll land to that condition but yeah theoretically it should=
 be false. Will revise this function.

>=20
>=20
>> + gchar *endptr;
>> +
>> + if(dev !=3D NULL && f !=3D NULL && val !=3D NULL) {
>> + gchar *file_path =3D g_build_filename(PROCFS_PS_DIR, dev, f, NULL);
>> + gchar *file_content;
>> + gsize length;
>> +
>> + if(g_file_get_contents(file_path, &file_content, &length, NULL)) {
>> + *val =3D g_ascii_strtoll(file_content, &endptr, 10);
>> + } else {
>> + ret =3D FALSE;
>> + }
>> +
>> + g_free(file_content);
>> + g_free(file_path);
>> + return ret;
>=20
> This return above seems to be superfluous in view of the next statement.
>=20
>=20
>> + }
>> + return ret;
>> +}
>> +
>> +const char* pm_battery_icon(void)
>> +{
>> + const char *icon;
>> +
>> + gint64 temp_val =3D 0;
>=20
> Space and tabs are mixed here. There are some other instances of this in
> this patch.

Yeah, I noticed that once I submitted, I wonder why I am not seeing this ga=
rbage locally in vim. Need to check.

>=20
>=20
>> + gint64 ac_sts =3D 0;
>=20
> Nitpick: batt_present and batt_percentage are nicely spelled out. Could
> this be called also ac_status?

True, will make it uniform.

>=20
>=20
>> + gint64 batt_present =3D 0;
>> + gint64 batt_percentage =3D 0;
>> +
>> + if(batt_exist =3D=3D 0)
>> + return NULL;
>> +
>> + /* Check battery presence */
>> + if(read_val_from_file(batt_dev, "present", &temp_val))
>> + batt_present =3D temp_val;
>=20
> Nitpick: I wonder if checking for "present" is the best way to determine
> if a battery is present. This file might not exist in all drivers, in
> which case the battery is considered to be present (according to sysfs
> docs). On the other hand, as a first version I consider it good enough,
> it can be iterated, when/if needed.

In the whatever drivers I have seen so far while implementing this, present=
 is the base entry for any battery device
in power subsystem.

>=20
>=20
>> +
>> + if(batt_present =3D=3D 0) {
>> + /* Battery is removed */
>> + icon =3D "ac-adapter.png";
>> + return icon;
>> + }
>> +
>> + /* Check Adaptor status*/
>> + if(read_val_from_file(ac_dev, "online", &temp_val))
>> + ac_sts =3D temp_val;
>> +
>=20
> ac_exist isn't verified before trying to read. While I believe it
> shouldn't lead to anything bad, but it is checked later when the icon is
> displayed.

Will add the check.

Thanks for the review,
Dixit

--8CNih5y03UqSoPh05ETi
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<blockquote>I'm not very well versed in gtk, so if anyone tells me that it =
is<br />idiomatic, I will believe it, but: why are these guchar? The code<b=
r />doesn't seem to do anything char-like with them, they are used as bools=
.<br />Why not guint, or gboolean?</blockquote>
Ideally it should be gboolean, I dont recall why I kept it guchar. I will s=
hift to gboolean and see.<br />
<blockquote>
<blockquote>+static gboolean read_val_from_file(const gchar *dev, const gch=
ar *f, gint64 *val)<br />+{<br />+ gboolean ret =3D TRUE;</blockquote>
Should this be not FALSE by default? If the next "if" branch is false,<br /=
>it stays TRUE, even though it fails to read anything.</blockquote>
Its rare that we'll land to that condition but yeah theoretically it should=
 be false. Will revise this function.<br />
<blockquote>
<blockquote>+ gchar *endptr;<br />+<br />+ if(dev !=3D NULL &amp;&amp; f !=
=3D NULL &amp;&amp; val !=3D NULL) {<br />+ gchar *file_path =3D g_build_fi=
lename(PROCFS_PS_DIR, dev, f, NULL);<br />+ gchar *file_content;<br />+ gsi=
ze length;<br />+<br />+ if(g_file_get_contents(file_path, &amp;file_conten=
t, &amp;length, NULL)) {<br />+ *val =3D g_ascii_strtoll(file_content, &amp=
;endptr, 10);<br />+ } else {<br />+ ret =3D FALSE;<br />+ }<br />+<br />+ =
g_free(file_content);<br />+ g_free(file_path);<br />+ return ret;</blockqu=
ote>
This return above seems to be superfluous in view of the next statement.<br=
 /><br />
<blockquote>+ }<br />+ return ret;<br />+}<br />+<br />+const char* pm_batt=
ery_icon(void)<br />+{<br />+ const char *icon;<br />+<br />+ gint64 temp_v=
al =3D 0;</blockquote>
Space and tabs are mixed here. There are some other instances of this in<br=
 />this patch.</blockquote>
Yeah, I noticed that once I submitted, I wonder why I am not seeing this ga=
rbage locally in vim. Need to check.<br />
<blockquote>
<blockquote>+ gint64 ac_sts =3D 0;</blockquote>
Nitpick: batt_present and batt_percentage are nicely spelled out. Could<br =
/>this be called also ac_status?</blockquote>
True, will make it uniform.<br />
<blockquote>
<blockquote>+ gint64 batt_present =3D 0;<br />+ gint64 batt_percentage =3D =
0;<br />+<br />+ if(batt_exist =3D=3D 0)<br />+ return NULL;<br />+<br />+ =
/* Check battery presence */<br />+ if(read_val_from_file(batt_dev, "presen=
t", &amp;temp_val))<br />+ batt_present =3D temp_val;</blockquote>
Nitpick: I wonder if checking for "present" is the best way to determine<br=
 />if a battery is present. This file might not exist in all drivers, in<br=
 />which case the battery is considered to be present (according to sysfs<b=
r />docs). On the other hand, as a first version I consider it good enough,=
<br />it can be iterated, when/if needed.</blockquote>
In the whatever drivers I have seen so far while implementing this, present=
 is the base entry for any battery device</div>
<div>in power subsystem.<br />
<blockquote>
<blockquote>+<br />+ if(batt_present =3D=3D 0) {<br />+ /* Battery is remov=
ed */<br />+ icon =3D "ac-adapter.png";<br />+ return icon;<br />+ }<br />+=
<br />+ /* Check Adaptor status*/<br />+ if(read_val_from_file(ac_dev, "onl=
ine", &amp;temp_val))<br />+ ac_sts =3D temp_val;<br />+</blockquote>
ac_exist isn't verified before trying to read. While I believe it<br />shou=
ldn't lead to anything bad, but it is checked later when the icon is<br />d=
isplayed.</blockquote>
Will add the check.</div>
<div>&nbsp;</div>
<div>Thanks for the review,</div>
<div>Dixit</div>

--8CNih5y03UqSoPh05ETi--

