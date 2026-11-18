Subject: Re: [meta-selinux][master][PATCH] libselinux: Reduce memory needed in libselinux
To: yocto-patches@lists.yoctoproject.org
From: "Yannik Tannhaeuser" <yannik.tannhaeuser@gmail.com>
X-Originating-Location: Munich, Bavaria, DE (212.204.93.23)
X-Originating-Platform: Linux Firefox 157
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 18 Nov 2026 06:00:28 -0800
References: <20260807133123.424089-1-yannik.tannhaeuser@gmail.com> <1880129.1787219504609892194@lists.yoctoproject.org> <22d604f0-a171-4808-bd22-61b6a6d812a5@cetc.com.cn>
In-Reply-To: <22d604f0-a171-4808-bd22-61b6a6d812a5@cetc.com.cn>
Message-ID: <925933.1795010428696811788@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="gJmhYbeUS3kx0LEEhkWH"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 14:00:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5471

--gJmhYbeUS3kx0LEEhkWH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

we noticed that the memory consumption of libselinux went up significantly =
after an update. During testing we tried out this flag which lowered it aga=
in.

Could you please have a look if we can merge the same patch for wrynose? Th=
anks!
https://lists.yoctoproject.org/g/yocto-patches/message/4650

Regards,
Yannik

--gJmhYbeUS3kx0LEEhkWH
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>we noticed that the memory consumption of libselinux went up significa=
ntly after an update. During testing we tried out this flag which lowered i=
t again.</div>
<div>&nbsp;</div>
<div>Could you please have a look if we can merge the same patch for wrynos=
e? Thanks!<br /><a href=3D"https://lists.yoctoproject.org/g/yocto-patches/m=
essage/4650" target=3D"_blank" rel=3D"noopener">https://lists.yoctoproject.=
org/g/yocto-patches/message/4650</a></div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Yannik</div>

--gJmhYbeUS3kx0LEEhkWH--
