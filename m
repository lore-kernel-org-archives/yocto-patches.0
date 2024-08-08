Return-Path: <Yash.Shinde@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152AC3DA4A
	for <webhook@archiver.kernel.org>; Thu,  8 Aug 2024 07:15:35 +0000 (UTC)
Subject: Re: [meta-lts-mixins][kirkstone/rust][PATCH] rust: Add new varaible RUST_ENABLE_EXTRA_TOOLS
To: yocto-patches@lists.yoctoproject.org
From: "Yash Shinde" <Yash.Shinde@windriver.com>
X-Originating-Location: Bengaluru, Karnataka, IN (49.204.85.206)
X-Originating-Platform: Windows Chrome 127
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 08 Aug 2024 00:15:29 -0700
References: <30467.1723016921022337678@lists.yoctoproject.org>
In-Reply-To: <30467.1723016921022337678@lists.yoctoproject.org>
Message-ID: <30467.1723101329335439755@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="CyWl8OtJvGPKx6X58075"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 Aug 2024 07:15:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/515

--CyWl8OtJvGPKx6X58075
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I checked for the reproducibility issue on rust v1.75 i.e current master (u=
sing cmd: "oe-selftest -v -j 32 -K -r reproducible")
by enabling the "rust-demangler" tool as given in this patch.

There were no errors seen and tests were passed.
Rust version will be upgraded in master with rust v1.77 soon.
We need to check reproducibility with enabling the "rust-demangler" tool th=
ere as well.

If the tests pass, we can enable the tool in master, unless it doesn't impa=
ct any other regressions.

Regards,
Yash

--CyWl8OtJvGPKx6X58075
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>I checked for the reproducibility issue on rust v1.75 i.e current mast=
er (using cmd: "oe-selftest -v -j 32 -K -r reproducible")<br />by enabling =
the "rust-demangler" tool as given in this patch.<br /><br />There were no =
errors seen and tests were passed.<br />Rust version will be upgraded in ma=
ster with rust v1.77 soon.<br />We need to check reproducibility with enabl=
ing the "rust-demangler" tool there as well.<br /><br />If the tests pass, =
we can enable the tool in master, unless it doesn't impact any other regres=
sions.<br /><br />Regards,<br />Yash</div>

--CyWl8OtJvGPKx6X58075--

