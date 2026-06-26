Return-Path: <livinsunny519@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B65C43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 16:43:58 +0000 (UTC)
Subject: Re: [meta-lts-collab][kirkstone][PATCH V2 1/7] strongswan: Fix CVE-2026-35328
To: yocto-patches@lists.yoctoproject.org
From: "Livin Sunny" <livinsunny519@gmail.com>
X-Originating-Location: Olathe, Kansas, US (185.153.204.24)
X-Originating-Platform: Windows Firefox 152
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 26 Jun 2026 09:43:55 -0700
References: <20260623061001.644583-1-nitin.wankhade@kpit.com>
In-Reply-To: <20260623061001.644583-1-nitin.wankhade@kpit.com>
Message-ID: <79924.1782492235454273368@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="CC1w6sSSosBZh4HpAr0W"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Jun 2026 16:43:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4307

--CC1w6sSSosBZh4HpAr0W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 01:10 AM, Nitin Wankhade wrote:

>=20
> From: Nitin Wankhade <nitin.wankhade333@gmail.com>
>=20
> Upstream-Status: Backport [ https://snapshot.debian.org/archive/debian-se=
curity-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0=
.1-6%2Bdeb13u5.debian.tar.xz
> ]
>=20
> Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
> ---
> .../strongswan/files/CVE-2026-35328.patch | 42 +++++++++++++++++++
> .../strongswan/strongswan_5.9.13.bbappend | 4 ++
> 2 files changed, 46 insertions(+)
> create mode 100644
> meta-networking/recipes-support/strongswan/files/CVE-2026-35328.patch
> create mode 100644
> meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
>=20
> diff --git
> a/meta-networking/recipes-support/strongswan/files/CVE-2026-35328.patch
> b/meta-networking/recipes-support/strongswan/files/CVE-2026-35328.patch
> new file mode 100644
> index 0000000..32a23b3
> --- /dev/null
> +++
> b/meta-networking/recipes-support/strongswan/files/CVE-2026-35328.patch
> @@ -0,0 +1,42 @@
> +From: Tobias Brunner <tobias@strongswan.org>
> +Date: Wed, 25 Mar 2026 10:17:46 +0100
> +Subject: tls-server: Prevent infinite loop if supported versions are too
> + short
> +
> +If the extension doesn't contain a multiple of two bytes, the previous
> +code would get stuck in an infinite loop as `remaining()` continued to
> +return TRUE while `read_uint16()` failed to parse a value. Initiating
> +several connections with such an extension allows a DoS attack as no
> +threads would eventually be available to handle packets/events.
> +
> +Fixes: 7fbe2e27ecf6 ("tls-server: TLS 1.3 support for TLS server
> implementation")
> +Fixes: CVE-2026-35328
> +
> +CVE: CVE-2026-35328
> +Upstream-Status: Backport [ https://snapshot.debian.org/archive/debian-s=
ecurity-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.=
0.1-6%2Bdeb13u5.debian.tar.xz
> ]
> +Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>

For all the patches in this series, could you please include direct links t=
o the backport patches instead of attaching a tar file?
e.g: https://github.com/strongswan/strongswan/commit/56c7f0d13dffcfebf42554=
70e375234144d28134 for CVE-2026-35328

--CC1w6sSSosBZh4HpAr0W
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Tue, Jun 23, 2026 at 01:10 AM, Nitin Wankhade wrote:</div>
<div>
<blockquote>From: Nitin Wankhade &lt;nitin.wankhade333@gmail.com&gt;<br /><=
br />Upstream-Status: Backport [<a href=3D"https://snapshot.debian.org/arch=
ive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/s=
trongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz" target=3D"_blank" rel=3D"noopene=
r">https://snapshot.debian.org/archive/debian-security-debug/20260422T12542=
3Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.x=
z</a>]<br /><br />Signed-off-by: Nitin Wankhade &lt;nitin.wankhade333@gmail=
.com&gt;<br />---<br />.../strongswan/files/CVE-2026-35328.patch | 42 +++++=
++++++++++++++<br />.../strongswan/strongswan_5.9.13.bbappend | 4 ++<br />2=
 files changed, 46 insertions(+)<br />create mode 100644 meta-networking/re=
cipes-support/strongswan/files/CVE-2026-35328.patch<br />create mode 100644=
 meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend<br /=
><br />diff --git a/meta-networking/recipes-support/strongswan/files/CVE-20=
26-35328.patch b/meta-networking/recipes-support/strongswan/files/CVE-2026-=
35328.patch<br />new file mode 100644<br />index 0000000..32a23b3<br />--- =
/dev/null<br />+++ b/meta-networking/recipes-support/strongswan/files/CVE-2=
026-35328.patch<br />@@ -0,0 +1,42 @@<br />+From: Tobias Brunner &lt;tobias=
@strongswan.org&gt;<br />+Date: Wed, 25 Mar 2026 10:17:46 +0100<br />+Subje=
ct: tls-server: Prevent infinite loop if supported versions are too<br />+ =
short<br />+<br />+If the extension doesn't contain a multiple of two bytes=
, the previous<br />+code would get stuck in an infinite loop as `remaining=
()` continued to<br />+return TRUE while `read_uint16()` failed to parse a =
value. Initiating<br />+several connections with such an extension allows a=
 DoS attack as no<br />+threads would eventually be available to handle pac=
kets/events.<br />+<br />+Fixes: 7fbe2e27ecf6 ("tls-server: TLS 1.3 support=
 for TLS server implementation")<br />+Fixes: CVE-2026-35328<br />+<br />+C=
VE: CVE-2026-35328<br />+Upstream-Status: Backport [<a href=3D"https://snap=
shot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates=
/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz" target=3D"_b=
lank" rel=3D"noopener">https://snapshot.debian.org/archive/debian-security-=
debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2B=
deb13u5.debian.tar.xz</a>]<br />+Signed-off-by: Nitin Wankhade &lt;nitin.wa=
nkhade333@gmail.com&gt;</blockquote>
For all the patches in this series, could you please include direct links t=
o the backport patches instead of attaching a tar file?<br />e.g: <a href=
=3D"https://github.com/strongswan/strongswan/commit/56c7f0d13dffcfebf425547=
0e375234144d28134" target=3D"_blank" rel=3D"noopener">https://github.com/st=
rongswan/strongswan/commit/56c7f0d13dffcfebf4255470e375234144d28134</a> for=
 CVE-2026-35328</div>

--CC1w6sSSosBZh4HpAr0W--

