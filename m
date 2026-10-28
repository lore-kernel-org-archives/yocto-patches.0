Subject: Re: [wic][PATCH] wic-plugins: use iso-level 3 in isohybrid plugins for >4GB files
To: yocto-patches@lists.yoctoproject.org
From: "Gourav Singh" <gouravsingh@siemens.com>
X-Originating-Location: Chennai, Tamil Nadu, IN (167.103.89.15)
X-Originating-Platform: Windows Edge 156
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 28 Oct 2026 11:36:00 -0700
References: <20261028093240.614428-1-gouravsingh@siemens.com> <B49AD943-F7D4-479C-805B-B3EC5907E91D@arm.com>
In-Reply-To: <B49AD943-F7D4-479C-805B-B3EC5907E91D@arm.com>
Message-ID: <2714676.1793212560200819194@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="fTbW32OUvvuRlqTN5s7m"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 18:36:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5175

--fTbW32OUvvuRlqTN5s7m
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Ross,

Yes, cdrtools supports this as well.
According to the official mkisofs manpage [1], `-iso-level 3` enables multi=
-extent files to support files larger than 4 GB.
So `-iso-level 3` works with both cdrtools and xorriso.
[1] https://cdrtools.sourceforge.net/private/man/cdrecord/mkisofs.8.html

Thanks,
Gourav

--fTbW32OUvvuRlqTN5s7m
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Ross,<br /><br />Yes, cdrtools supports this as well.<br />Accordin=
g to the official mkisofs manpage [1], `-iso-level 3` enables multi-extent =
files to support files larger than 4 GB.<br />So `-iso-level 3` works with =
both cdrtools and xorriso.<br />[1] <a href=3D"https://cdrtools.sourceforge=
.net/private/man/cdrecord/mkisofs.8.html" target=3D"_blank" rel=3D"noopener=
">https://cdrtools.sourceforge.net/private/man/cdrecord/mkisofs.8.html</a><=
br /><br />Thanks,</div>
<div>Gourav</div>

--fTbW32OUvvuRlqTN5s7m--
