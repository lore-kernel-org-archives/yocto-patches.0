Return-Path: <rchiluka@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5020C61DE4
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 04:29:41 +0000 (UTC)
Subject: Re: [meta-selinux][PATCH] refpolicy_common: strip POLICY_CUSTOM_BUILDOPT before passing to make
To: yocto-patches@lists.yoctoproject.org
From: "Rohith Chiluka" <rchiluka@qti.qualcomm.com>
X-Originating-Location: Chennai, Tamil Nadu, IN (163.116.214.45)
X-Originating-Platform: Windows Edge 151
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 21:29:37 -0700
References: <20260812060045.244559-1-rchiluka@qti.qualcomm.com> <64883715-b8f8-4e62-81db-9a0c968a1a08@cetc.com.cn>
In-Reply-To: <64883715-b8f8-4e62-81db-9a0c968a1a08@cetc.com.cn>
Message-ID: <2992798.1788236977907424759@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="Zf250XWnwydLsEWlhQyR"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 01 Sep 2026 04:29:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4721

--Zf250XWnwydLsEWlhQyR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the suggestion. I did try that, but quoting doesn't solve the pr=
oblem in this case.
The reason is that EXTRA_OEMAKE is passed to make unquoted by oe_runmake ($=
{MAKE} ${EXTRA_OEMAKE}). So the shell splits the value into words based on =
spaces. When a layer uses :append like:
POLICY_CUSTOM_BUILDOPT:append =3D " option"

the value becomes CUSTOM_BUILDOPT=3D option, and the shell splits it into t=
wo words, CUSTOM_BUILDOPT=3D (empty) and option (treated as a make target).=
 That's what causes No rule to make target 'option'.

Adding quotes like CUSTOM_BUILDOPT=3D'${POLICY_CUSTOM_BUILDOPT}' doesn't he=
lp, because the quotes come from variable expansion, the shell treats them =
as literal characters, not as grouping. The value would become CUSTOM_BUILD=
OPT=3D' option', which splits into CUSTOM_BUILDOPT=3D' and=C2=A0option', so=
 make still fails (now with a stray quote in the target name).

.strip() is intended exactly for this: it removes only the leading/trailing=
 whitespace introduced by :append, giving a clean single token CUSTOM_BUILD=
OPT=3Doption. It also preserves any internal spaces, so multiple options (e=
.g. "opt1 opt2") still split correctly into separate make arguments.

So, I believe .strip() change is the correct fix here. Please let me know i=
f you see any issue with it.

--Zf250XWnwydLsEWlhQyR
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Thanks for the suggestion. I did try that, but quoting doesn't solve t=
he problem in this case.</div>
<div>The reason is that EXTRA_OEMAKE is passed to make unquoted by oe_runma=
ke (${MAKE} ${EXTRA_OEMAKE}). So the shell splits the value into words base=
d on spaces. When a layer uses :append like:</div>
<div>POLICY_CUSTOM_BUILDOPT:append =3D " option"</div>
<div>&nbsp;</div>
<div>the value becomes CUSTOM_BUILDOPT=3D option, and the shell splits it i=
nto two words, CUSTOM_BUILDOPT=3D (empty) and option (treated as a make tar=
get). That's what causes No rule to make target 'option'.</div>
<div>&nbsp;</div>
<div>Adding quotes like CUSTOM_BUILDOPT=3D'${POLICY_CUSTOM_BUILDOPT}' doesn=
't help, because the quotes come from variable expansion, the shell treats =
them as literal characters, not as grouping. The value would become CUSTOM_=
BUILDOPT=3D' option', which splits into CUSTOM_BUILDOPT=3D' and&nbsp;option=
', so make still fails (now with a stray quote in the target name).</div>
<div>&nbsp;</div>
<div>.strip() is intended exactly for this: it removes only the leading/tra=
iling whitespace introduced by :append, giving a clean single token CUSTOM_=
BUILDOPT=3Doption. It also preserves any internal spaces, so multiple optio=
ns (e.g. "opt1 opt2") still split correctly into separate make arguments.</=
div>
<div>&nbsp;</div>
<div>So, I believe .strip() change is the correct fix here. Please let me k=
now if you see any issue with it.</div>

--Zf250XWnwydLsEWlhQyR--

