Return-Path: <erik.schumacher@iris-sensing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA2FC77B7C
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 12:02:06 +0000 (UTC)
Subject: [ptest-runner][RFC] Implement ptest-runner to match previous documentation and current state of run-ptest scripts
To: yocto-patches@lists.yoctoproject.org
From: "Erik Schumacher" <erik.schumacher@iris-sensing.com>
X-Originating-Location: Berlin, State of Berlin, DE (213.61.209.158)
X-Originating-Platform: Linux Firefox 140
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 03 Jul 2025 05:02:02 -0700
Message-ID: <zPYp.1751544122388050827.FCRW@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="phxKX0cjAadYBCYU68l9"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Jul 2025 12:02:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1743

--phxKX0cjAadYBCYU68l9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

regarding the discussion on the docs mailing list about the behavior of the=
 ptest-runner [1], it got me thinking that maybe the tool that runs all pte=
sts should be adopted. There are a lot of run-ptest scripts that adhered to=
 the documentation and were carefully written to print "PASS:", "FAIL:" or =
"SKIP:" to report the test results. The change in the documentation that wa=
s just applied, does not fix the underlying problem that the ptest-runner i=
s currently not very useful. It will probably take a long time until all ru=
n-ptest scripts follow the new guidelines of what the scripts should print =
and how they should exit. Until then, the ptest-runner itself could be repl=
aced by a simple shell script that just runs all run-ptest scripts, as the =
output of ptest-runner (exit code and xml) might hide test failures and can=
 not be trusted.

In my opinion, a ptest-runner should work with what is already there. It sh=
ould parse the output, looking for lines starting with "PASS:", "FAIL:" or =
"SKIP:", keep track of the test cases inside a run-ptest script and should =
output valid junit.xml files.

Therefore, I implemented a proof-of-concept drop-in replacement in Python3,=
 using only built-in libraries. It's about 200 lines of code and does all t=
he above: Finding and selecting run-ptest scripts to run, parsing and colle=
cting stdout, analyzing the results and creating a junit.xml file. Some wor=
k is still needed to fix minor issues, but with this message I wanted to as=
k if you are interested in this re-implementation of the ptest-runner? And =
if so, how to proceed?

[1] https://lists.yoctoproject.org/g/docs/topic/113728319

Best regards
Erik Schumacher

--phxKX0cjAadYBCYU68l9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>&nbsp;</div>
<div>regarding the discussion on the docs mailing list about the behavior o=
f the ptest-runner [1], it got me thinking that maybe the tool that runs al=
l ptests should be adopted. There are a lot of run-ptest scripts that adher=
ed to the documentation and were carefully written to print "PASS:", "FAIL:=
" or "SKIP:" to report the test results. The change in the documentation th=
at was just applied, does not fix the underlying problem that the ptest-run=
ner is currently not very useful. It will probably take a long time until a=
ll run-ptest scripts follow the new guidelines of what the scripts should p=
rint and how they should exit. Until then, the ptest-runner itself could be=
 replaced by a simple shell script that just runs all run-ptest scripts, as=
 the output of ptest-runner (exit code and xml) might hide test failures an=
d can not be trusted.</div>
<div>&nbsp;</div>
<div>In my opinion, a ptest-runner should work with what is already there. =
It should parse the output, looking for lines starting with "PASS:", "FAIL:=
" or "SKIP:", keep track of the test cases inside a run-ptest script and sh=
ould output valid junit.xml files.</div>
<div>&nbsp;</div>
<div>Therefore, I implemented a proof-of-concept drop-in replacement in Pyt=
hon3, using only built-in libraries. It's about 200 lines of code and does =
all the above: Finding and selecting run-ptest scripts to run, parsing and =
collecting stdout, analyzing the results and creating a junit.xml file. Som=
e work is still needed to fix minor issues, but with this message I wanted =
to ask if you are interested in this re-implementation of the ptest-runner?=
 And if so, how to proceed?</div>
<div>&nbsp;</div>
<div>[1] <a href=3D"https://lists.yoctoproject.org/g/docs/topic/113728319" =
target=3D"_blank" rel=3D"noopener">https://lists.yoctoproject.org/g/docs/to=
pic/113728319</a></div>
<div>&nbsp;</div>
<div>Best regards</div>
<div>Erik Schumacher</div>

--phxKX0cjAadYBCYU68l9--

