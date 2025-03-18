Return-Path: <omri.sarig13@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BCEC282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 10:43:24 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.8804.1742294594046967916
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Mar 2025 03:43:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ww2cdVTk;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: omri.sarig13@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-307325f2436so52459701fa.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Mar 2025 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742294592; x=1742899392; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpAwDTUy7BmAvWx7V8b9c5n+v5IshaMw7iyRUUZlJ6U=;
        b=Ww2cdVTkJQF/Y57yP0m3f2p1JrbROhE8HmG3DrJLw9O4YzDpV1aUmqFvRmnfJK/moj
         PFbnQ6rOO28MSzEob0OB1EbYKxFecJ8g6KgAkAYrm7XUEEAOzEg099gUcOGz+1g9Rrkd
         rnqm7czT5+6AYMnWEDIaHxOM5gOJtZwtdMKoGQdLDmKJY5sowdSboMSTJdAcOhRwmJMW
         uHJU0b0774CHMEZIexy8SDWMWhrGmw/his2JrR/QhZiPyDHqI6YyeVolfiDGhNl8L3Sl
         9TgT0DIjVwiaYvwQM8QiEKG46al/uxf1SBxbXkW4bqaD2RwRzWRCqmi/DA0d3uWvitDO
         0Anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294592; x=1742899392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpAwDTUy7BmAvWx7V8b9c5n+v5IshaMw7iyRUUZlJ6U=;
        b=DCeBWPLOc6HaO/vmvESbhCMkrHlHDNkNdSZmBceeJBz22W8AI/P7LoTMUV1liyxndM
         WSWg7Tap2CdRcpxjXwkAaaCpkl5lZwpHZpeSjC7kFWgq6yQQwzbcXOFGadllDF/Vd6lT
         LL/pX6/HB9SqbmgRdGR6srMlmb86x+L3hQg9c9o8mLkUkG7gV7Jd5ebMGZiVYrqfuk/f
         2tF75KF2VNvIFpb9xC7pZPfXu5pwbhqQDP7bpyE8+lMQJMRBPOMYdUaXTDnSBOuRJ9P5
         Jw+JDsex8AmejIs73sn6x88i0UaRqknKSPPKCJKOb+VwBMos0t9efvCSYsQ8X8uY5V2M
         0vQA==
X-Gm-Message-State: AOJu0YxtBkScTYs6+BSgEuj2ncYe7U6OD0VjMeHAkx3O/GbrFa5vAzAI
	vjQ1bG3j3eODUfUJQgspmPzJxnOQDKS9mR022p3k+tXa7flu5iXI
X-Gm-Gg: ASbGncvJD8o8kGM6tJOMjMx8FLhVQ7oePGg/d8klhSee6oWLUWbs6aaWtE0j7ItdTmi
	ReeofHQ2YzaieLREM/8qMpAKMANCr9PZZgRFAfHZsBL6tOJJogK6ZSTGlywQMk8kCP/hctKt9io
	UIMniT9fZ7ZKZPcv+YPc/7BWUvImBWcE6187CosZ8lX16qfDG9x9MoorXrf9mSoSGRVoXAYyKcu
	yGynMevcRZcllDdshJ5oyFZOV8n3ekWyP2TocWBqUomSf1btHOxotq7N7WVDcADhIDWtXPigAmO
	5J6GDKuCzVsC7KXUF2jkT0h2qAlI+Cmmrf42UDo2XAwa9cgJ3g==
X-Google-Smtp-Source: AGHT+IGxsKsUYgyXhndiQIkWL/KdV/mTLcQyhQWP1QfasCHU0yx3Mw0ljk/NzNdN3SpZCV4TCjZquA==
X-Received: by 2002:a2e:a7ca:0:b0:30b:f23e:77fb with SMTP id 38308e7fff4ca-30c4a8761ffmr87752161fa.21.1742294591481;
        Tue, 18 Mar 2025 03:43:11 -0700 (PDT)
Received: from [172.16.6.176] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f117161sm19131971fa.53.2025.03.18.03.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:43:10 -0700 (PDT)
Message-ID: <b5bf682d-62a0-4388-9196-025e8fc32a10@gmail.com>
Date: Tue, 18 Mar 2025 11:42:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH v2 3/3] oeqa/cases/tpm2: Add
 tpm2-pkcs11-tools sanity test
To: akuster808@gmail.com
Cc: yocto-patches@lists.yoctoproject.org,
 Mikko Rapeli <mikko.rapeli@linaro.org>
References: <20250312103241.2526274-1-omri.sarig13@gmail.com>
 <20250312103241.2526274-4-omri.sarig13@gmail.com> <Z9FkFWK5JCRTELe9@nuoska>
 <ff0fda36-0658-4e5f-83e6-917908884c4f@gmail.com> <Z9FsubzQXInmctnY@nuoska>
Content-Language: en-US
From: Omri Sarig <omri.sarig13@gmail.com>
In-Reply-To: <Z9FsubzQXInmctnY@nuoska>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Mar 2025 10:43:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1215

Hi Armin,

Haven't heard anything in about a week.
Will you consider adding these patches to meta-security?


Thanks,
With Kind Regards,
Omri

On 3/12/25 12:15, Mikko Rapeli wrote:
> Hi,
>
> On Wed, Mar 12, 2025 at 12:07:29PM +0100, Omri Sarig wrote:
>> On 3/12/25 11:38, Mikko Rapeli wrote:
>>> Hi,
>> Thanks for the fast reply!
>>
>>> On Wed, Mar 12, 2025 at 11:32:41AM +0100, Omri Sarig via lists.yoctoproject.org wrote:
>>>> Add a very simple sanity test, which ensures that tpm2_ptool can run
>>>> without problems when the relevant package is available.
>>>>
>>>> This test case is available here to help prevent future errors, where
>>>> the tool is unable to run after installation, due to missing
>>>> dependencies for example.
>>>>
>>>> Contrary to other tests in the file, this test does not communicate with
>>>> the TPM module itself, it only ensures that the tool (tpm2_ptool) can be
>>>> loaded without any errors. Therefore, we don't need to depend on
>>>> anything other than having the package installed.
>>>>
>>>> Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
>>>> ---
>>>>    meta-tpm/lib/oeqa/runtime/cases/tpm2.py | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/meta-tpm/lib/oeqa/runtime/cases/tpm2.py b/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
>>>> index 8e90dc9..c2e6dfa 100644
>>>> --- a/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
>>>> +++ b/meta-tpm/lib/oeqa/runtime/cases/tpm2.py
>>>> @@ -67,3 +67,8 @@ class Tpm2Test(OERuntimeTestCase):
>>>>        def test_tpm2_swtpm_reset(self):
>>>>             (status, output) = self.target.run('swtpm_ioctl -i --tcp :2322')
>>>>             self.assertEqual(status, 0, msg="swtpm reset failed: %s" % output)
>>>> +
>>>> +    @OEHasPackage(['tpm2-pkcs11-tools'])
>>>> +    def test_tpm2_pkcs11_tools(self):
>>>> +        (status, output) = self.target.run("tpm2_ptool --help")
>>>> +        self.assertEqual(status, 0, msg="Module cannot be run with error: %s" % output)
>>> Thanks! This good to start with. I think it's a separate question now if
>>> meta-tpm test images will include tpm2-pkcs11-tools and actually run
>>> this test.
>> I've looked into it now.
>> If I understand it correctly, and the image used for testing is
>> security-tpm2-image
>> (meta-security/meta-tpm/recipes-core/images/security-tpm2-image.bb), then
>> the image already have tpm2-pkcs11-tools implicitly installed in it.
>>
>> This is done as the image have the recipe of swtpm and the config of gnutls,
>> which adds tpm2-pkcs11-tools to the runtime dependencies of swtpm.
>>
>> I think we can do one of the following:
>>
>> 1. Update the image to explicitly install tpm2-pkcs11-tools (as a package in
>> IMAGE_INSTALL).
>> 2. Update the commit message to add the above explanation, so users will
>> know that the tool is added to the image (and thus tested).
>> 3. Leave the commits as-is.
>>
>> What do you think makes the most sense?
> If the image already has it then I think we can leave as is.
>
> But Armin as the layer maintainer can decide.
>
> Cheers,
>
> -Mikko

