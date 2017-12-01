<#if comment??>
/**
 * 获取${comment}
 *
 * @return ${comment}
 */
</#if>
public ${type} <#if type='boolean'>is<#else>get</#if>${name?cap_first}() {
    return ${name};
}