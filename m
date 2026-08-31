Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5339CC61DD3
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 09:33:02 +0000 (UTC)
Subject: meta-openjdk: A modern replacement for meta-java
To: yocto-patches@lists.yoctoproject.org
From: "Adam Duskett" <adam.duskett@amarulasolutions.com>
X-Originating-Location: Almere Stad, Flevoland, NL (77.250.178.78)
X-Originating-Platform: Linux Firefox 154
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 07:38:31 -0700
Message-ID: <xBB4.1788187111192557019.ULaN@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="zZzpjKF39vNgboL3s96p"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 01 Sep 2026 09:33:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4722

--zZzpjKF39vNgboL3s96p
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hey all! Back on 20.01.2025, Tim Orling wrote a post about the state of met=
a-java found here: https://lists.yoctoproject.org/g/yocto-patches/message/9=
86

In the message, he states:
- He is the final maintainer of the four maintainers of meta-java that resp=
onds to emails.
- meta-java is mostly on life support,
- Any patches submitted to meta-java must build on master
- He wants to keep JRE8 alive
- Newer JDKs are still not added
- Until JRE8 compiles, he can't merge any new patches

If you search for java on the layer index, there are four other layers:
meta-azul-zulu-java: Last commit: 7 years, 9 months ago
meta-oracle-java: Last commit: 9 years ago (master branch)
meta-zulu-java: Last commit: 7 years, 9 months ago (master branch)
meta-openjdk-temurin: Last commit: 4 months, 2 weeks ago

meta-openjdk-temurin is an interesting layer as it is fairly recent, and su=
pports JRE8, 11, 17, 21, and 25.
However, they are pre-built binary packages, which can be a major turnoff.

In an effort to provide recipes that allow for modern OpenJDK built from so=
urce,
I have created meta-openjdk: https://github.com/amarula/meta-openjdk

meta-openjdk features support:
- Support for building OpenJDK 17, 21, 25, and 26 from source
- cross-compiles OpenJDK from source
- Target builds are bootstrapped from openjdk-bin-native
- Passes oelint-adv and yocto-check-layer
- Supports Scarthgap and Wrynose (and master of course)

Differences between meta-java are:
- No more JRE7 or 8.
- java-native is downloaded in binary package form. Preventing the need
to download/build a bunch of ${java-version} - 1 recipes to eventually
build the preferred version
- Any package marked as deprecated or abandoned is removed.
- ca-certificates-java is updated to the latest release
- ant is gone (working on it right now)

And possibly the best feature: Offline maven builds!
`bitbake -cdo_maven_update_deps $recipe` generates a ${BPN}-deps.inc file
much like the `do_update_crates` method in the cargo-update-recipe-crates.b=
bclass file!

I have included an example package found at recipes-support/sqlite-jdbc/ sq=
lite-jdbc_3.53.4.0.bb
for anyone who wants to use maven with java.

I would very much appreciate any feedback, bug reports or pull requests if =
you have a need
for Yocto and modern java!

Thanks again!

--zZzpjKF39vNgboL3s96p
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hey all! Back on 20.01.2025, Tim Orling wrote a post about the state o=
f meta-java found here: <a href=3D"https://lists.yoctoproject.org/g/yocto-p=
atches/message/986" target=3D"_blank" rel=3D"noopener">https://lists.yoctop=
roject.org/g/yocto-patches/message/986</a></div>
<div>&nbsp;</div>
<div>In the message, he states:</div>
<div>&nbsp; - He is the final maintainer of the four maintainers of meta-ja=
va that responds to emails.</div>
<div>&nbsp; - meta-java is mostly on life support,&nbsp;</div>
<div>&nbsp; - Any patches submitted to meta-java must build on master</div>
<div>&nbsp; - He wants to keep JRE8 alive</div>
<div>&nbsp; - Newer JDKs are still not added</div>
<div>&nbsp; - Until JRE8 compiles, he can't merge any new patches</div>
<div>&nbsp;</div>
<div>If you search for java on the layer index, there are four other layers=
:</div>
<div>&nbsp; meta-azul-zulu-java: Last commit: 7 years, 9 months ago&nbsp;</=
div>
<div>&nbsp; meta-oracle-java: Last commit: 9 years ago (master branch)</div=
>
<div>&nbsp; meta-zulu-java: Last commit: 7 years, 9 months ago (master bran=
ch)</div>
<div>&nbsp; meta-openjdk-temurin: Last commit: 4 months, 2 weeks ago</div>
<div>&nbsp;</div>
<div>meta-openjdk-temurin is an interesting layer as it is fairly recent, a=
nd supports JRE8, 11, 17, 21, and 25.</div>
<div>However, they are pre-built binary packages, which can be a major turn=
off.</div>
<div>&nbsp;</div>
<div>In an effort to provide recipes that allow for modern OpenJDK built fr=
om source,</div>
<div>I have created meta-openjdk: <a href=3D"https://github.com/amarula/met=
a-openjdk" target=3D"_blank" rel=3D"noopener">https://github.com/amarula/me=
ta-openjdk</a></div>
<div>&nbsp;</div>
<div>meta-openjdk features support:</div>
<div>&nbsp; - Support for building OpenJDK 17, 21, 25, and 26 from source</=
div>
<div>&nbsp; - cross-compiles OpenJDK from source</div>
<div>&nbsp; - Target builds are bootstrapped from openjdk-bin-native</div>
<div>&nbsp; - Passes oelint-adv and yocto-check-layer</div>
<div>&nbsp; - Supports Scarthgap and Wrynose (and master of course)</div>
<div>&nbsp;</div>
<div>Differences between meta-java are:</div>
<div>&nbsp; - No more JRE7 or 8.</div>
<div>&nbsp; - java-native is downloaded in binary package form. Preventing =
the need</div>
<div>&nbsp; &nbsp; to download/build a bunch of ${java-version} - 1 recipes=
 to eventually</div>
<div>&nbsp; &nbsp; build the preferred version</div>
<div>
<div>&nbsp; - Any package marked as deprecated or abandoned is removed.</di=
v>
<div>&nbsp; - ca-certificates-java is updated to the latest release</div>
<div>&nbsp; - ant is gone (working on it right now)</div>
</div>
<div>&nbsp;</div>
<div>And possibly the best feature: Offline maven builds!&nbsp;</div>
<div><span style=3D"font-family: monospace;"><span style=3D"color: #000000;=
 background-color: #ffffff;" data-darkreader-inline-color=3D"" data-darkrea=
der-inline-bgcolor=3D"">`bitbake -cdo_maven_update_deps</span> $recipe` gen=
erates a ${BPN}-deps.inc file</span></div>
<div><span style=3D"font-family: monospace;">much like the `do_update_crate=
s` method in the <span style=3D"font-family: monospace;"><span style=3D"col=
or: #000000; background-color: #ffffff;" data-darkreader-inline-color=3D"" =
data-darkreader-inline-bgcolor=3D"">cargo-update-recipe-crates.bbclass</spa=
n><span style=3D"color: #000000; background-color: #ffffff;" data-darkreade=
r-inline-color=3D"" data-darkreader-inline-bgcolor=3D""> </span>file!</span=
></span></div>
<div>&nbsp;</div>
<div>I have included an example package found at <span style=3D"font-family=
: monospace;"><span style=3D"color: #000000; background-color: #ffffff;" da=
ta-darkreader-inline-color=3D"" data-darkreader-inline-bgcolor=3D"">recipes=
-support/sqlite-jdbc/<span style=3D"font-family: monospace;"><span style=3D=
"color: #000000; background-color: #ffffff;" data-darkreader-inline-color=
=3D"" data-darkreader-inline-bgcolor=3D"">sqlite-jdbc_3.53.4.0.bb</span></s=
pan></span></span><span style=3D"font-family: monospace;"><span style=3D"co=
lor: #000000; background-color: #ffffff;" data-darkreader-inline-color=3D""=
 data-darkreader-inline-bgcolor=3D""><span style=3D"font-family: monospace;=
"></span></span></span></div>
<div><span style=3D"font-family: monospace;"><span style=3D"color: #000000;=
 background-color: #ffffff;" data-darkreader-inline-color=3D"" data-darkrea=
der-inline-bgcolor=3D""><span style=3D"font-family: monospace;"><span style=
=3D"color: #000000; background-color: #ffffff;" data-darkreader-inline-colo=
r=3D"" data-darkreader-inline-bgcolor=3D"">for anyone who wants to use mave=
n with java.</span></span></span></span></div>
<div>&nbsp;</div>
<div><span style=3D"font-family: monospace;"><span style=3D"color: #000000;=
 background-color: #ffffff;" data-darkreader-inline-color=3D"" data-darkrea=
der-inline-bgcolor=3D""><span style=3D"font-family: monospace;"><span style=
=3D"color: #000000; background-color: #ffffff;" data-darkreader-inline-colo=
r=3D"" data-darkreader-inline-bgcolor=3D"">I would very much appreciate any=
 feedback, bug reports or pull requests if you have a need</span></span></s=
pan></span></div>
<div><span style=3D"font-family: monospace;"><span style=3D"color: #000000;=
 background-color: #ffffff;" data-darkreader-inline-color=3D"" data-darkrea=
der-inline-bgcolor=3D""><span style=3D"font-family: monospace;"><span style=
=3D"color: #000000; background-color: #ffffff;" data-darkreader-inline-colo=
r=3D"" data-darkreader-inline-bgcolor=3D"">for Yocto and modern java!</span=
></span></span></span></div>
<div>&nbsp;</div>
<div><span style=3D"font-family: monospace;"><span style=3D"color: #000000;=
 background-color: #ffffff;" data-darkreader-inline-color=3D"" data-darkrea=
der-inline-bgcolor=3D""><span style=3D"font-family: monospace;"><span style=
=3D"color: #000000; background-color: #ffffff;" data-darkreader-inline-colo=
r=3D"" data-darkreader-inline-bgcolor=3D"">Thanks again!</span></span></spa=
n></span></div>
<div>&nbsp;</div>

--zZzpjKF39vNgboL3s96p--

