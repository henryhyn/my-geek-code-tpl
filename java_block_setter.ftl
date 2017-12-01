<#if comment??>
/**
 * 设置${comment}
 *
 * @param ${name} ${comment}
 */
</#if>
public void set${name?cap_first}(${type} ${name}) {
    this.${name} = ${name};
}