import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { safetyDetect } from '@kit.DeviceSecurityKit';

@Entry
@Component
struct Index {
  @State safetyResult: string = 'Safety Result';

  build() {
    Column({ space: 15 }) {
      Text('Safety Result: ' + this.safetyResult)

      Button("Check Safety").onClick(async () => {
        const TAG = "SafetyDetectJsTest";

        try {
          hilog.info(0x0000, TAG, 'CheckSysIntegrityOnLocal begin.');
          const result: string = await safetyDetect.checkSysIntegrityOnLocal();
          hilog.info(0x0000, TAG, 'Succeeded in checkSysIntegrityOnLocal: %{public}s', JSON.stringify(result));
          this.safetyResult = JSON.stringify(result)
        } catch (err) {
          let e: BusinessError = err as BusinessError;
          hilog.error(0x0000, TAG, 'CheckSysIntegrityOnLocal failed: %{public}d %{public}s', e.code, e.message);
          this.safetyResult = e.code + ' ' + e.message
        }
      })

    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }
}